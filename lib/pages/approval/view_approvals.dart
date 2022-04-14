import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewApprovals extends StatefulWidget {
  const ViewApprovals({Key? key}) : super(key: key);

  @override
  _ViewApprovalsState createState() => _ViewApprovalsState();
}

class _ViewApprovalsState extends State<ViewApprovals> {
  Future<void> approveArt(String musicName, String artID) async {
    CollectionReference musicCollection =
        FirebaseFirestore.instance.collection('MUSIC');
    CollectionReference artCollection =
        FirebaseFirestore.instance.collection('ART');

    QuerySnapshot musicSnapshot = await FirebaseFirestore.instance
        .collection('MUSIC')
        .where('name', isEqualTo: musicName)
        .get();
    DocumentSnapshot artSnapshot =
        await FirebaseFirestore.instance.collection('ART').doc(artID).get();

    if (musicSnapshot.docs.isNotEmpty) {
      List<dynamic> pending = musicSnapshot.docs.first.get('pendingApprovals');
      List<dynamic> approved = musicSnapshot.docs.first.get('approvals');
      List<dynamic> artApproved = artSnapshot.get('approvedFor');
      pending.remove(artID);
      approved.add(artID);
      String musicID = musicSnapshot.docs.first.id;
      artApproved.add(musicID);
      musicCollection
          .doc(musicID)
          .update({'pendingApprovals': pending})
          .then((value) => print(
              "(accept) Removed pending approval ( art: $artID , music: $musicID )"))
          .catchError((e) => print("PENDING: UPDATING PENDING ERROR: $e"));
      musicCollection
          .doc(musicID)
          .update({'approvals': approved})
          .then((value) => print(
              "(accept) Added approved artwork ( art: $artID , music: $musicID )"))
          .catchError((e) => print("PENDING: UPDATING APPROVED ERROR: $e"));
      artCollection
          .doc(artID)
          .update({'approvedFor': artApproved})
          .then((value) => print(
              "(accept) Added approved artwork to art ( art: $artID , music: $musicID )"))
          .catchError((e) => print("PENDING: UPDATING ART ERROR"));
    }
  }

  Future<void> rejectArt(String musicName, String artID) async {
    CollectionReference musicCollection =
        FirebaseFirestore.instance.collection('MUSIC');

    QuerySnapshot musicSnapshot = await FirebaseFirestore.instance
        .collection('MUSIC')
        .where('name', isEqualTo: musicName)
        .get();

    if (musicSnapshot.docs.isNotEmpty) {
      List<dynamic> pending = musicSnapshot.docs.first.get('pendingApprovals');
      pending.remove(artID);
      String musicID = musicSnapshot.docs.first.id;
      musicCollection
          .doc(musicID)
          .update({'pendingApprovals': pending})
          .then((value) => print(
              "(reject) Removed pending approval ( art: $artID , music: $musicID )"))
          .catchError((e) => print("PENDING: UPDATING PENDING ERROR: $e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
        .collection('MUSIC')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();

    final Stream<QuerySnapshot> _artStream =
        FirebaseFirestore.instance.collection('ART').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _musicStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          //turn a collection of documents into a list and display as ListTile widgets
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if (data['pendingApprovals'].isNotEmpty) {
              return StreamBuilder(
                stream: _artStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> artSnapshot) {
                  if (artSnapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (artSnapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  }
                  List<Widget> arts = [];
                  arts.add(Text(data['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)));
                  artSnapshot.data!.docs.forEach((element) {
                    if (data['pendingApprovals'].contains(element.id)) {
                      arts.add(Text(element.get('name')));
                      arts.add(TextButton(
                        child: const Text("Approve"),
                        onPressed: () {
                          approveArt(data['name'], element.id);
                        },
                      ));
                      arts.add(TextButton(
                        child: const Text("Reject"),
                        onPressed: () {
                          rejectArt(data['name'], element.id);
                        },
                      ));
                    }
                  });
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: arts,
                  );
                },
              );
            } else {
              return const Text('');
            }
          }).toList(),
        );
      },
    );
  }
}
