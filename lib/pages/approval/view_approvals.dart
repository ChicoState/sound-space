import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewApprovals extends StatefulWidget {
  const ViewApprovals({Key? key}) : super(key: key);

  @override
  _ViewApprovalsState createState() => _ViewApprovalsState();
}

class _ViewApprovalsState extends State<ViewApprovals> {
  CollectionReference musicCollection =
      FirebaseFirestore.instance.collection('MUSIC');
  CollectionReference artCollection =
      FirebaseFirestore.instance.collection('ART');

  //Approving an artwork requires updating 3 lists:
  //  removing artID from MUSIC/pendingApprovals
  //  adding artID to MUSIC/approvals
  //  adding musicID to ART/approvedFor
  Future<void> approveArt(String musicName, String artID) async {
    QuerySnapshot musicSnapshot = await FirebaseFirestore.instance
        .collection('MUSIC')
        .where('name', isEqualTo: musicName)
        .get();
    DocumentSnapshot artSnapshot =
        await FirebaseFirestore.instance.collection('ART').doc(artID).get();

    if (musicSnapshot.docs.isNotEmpty) {
      //read and update the three lists
      List<dynamic> pending = musicSnapshot.docs.first.get('pendingApprovals');
      List<dynamic> approved = musicSnapshot.docs.first.get('approvals');
      List<dynamic> artApproved = artSnapshot.get('approvedFor');
      pending.remove(artID);
      approved.add(artID);
      String musicID = musicSnapshot.docs.first.id;
      artApproved.add(musicID);
      //update the FireStore documents
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

  /*  For future consideration:
   *  Maybe add another list of rejected approvals to MUSIC
   *  That way a user can't spam their art for approval
   */

  //rejecting an artwork only requires updating one list:
  //  removing artID from MUSIC/pendingApprovals
  Future<void> rejectArt(String musicName, String artID) async {
    CollectionReference musicCollection =
        FirebaseFirestore.instance.collection('MUSIC');

    QuerySnapshot musicSnapshot = await FirebaseFirestore.instance
        .collection('MUSIC')
        .where('name', isEqualTo: musicName)
        .get();

    if (musicSnapshot.docs.isNotEmpty) {
      //read and update the list
      List<dynamic> pending = musicSnapshot.docs.first.get('pendingApprovals');
      pending.remove(artID);
      String musicID = musicSnapshot.docs.first.id;
      //update the FireStore documents
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
    //streams to track
    final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
        .collection('MUSIC')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
    final Stream<QuerySnapshot> _artStream =
        FirebaseFirestore.instance.collection('ART').snapshots();

    //first StreamBuilder - tracks user's music documents
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
          //turn a collection of documents into a dictionary and iterate through
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            //check if the document has pending approvals
            if (data['pendingApprovals'].isNotEmpty) {
              //second StreamBuilder - tracks artworks - filters by pending approvals
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
                  //build the content of the widget as a List of Widgets
                  List<Widget> arts = [];
                  //WIDGET: title of the video (bolded)
                  arts.add(Text(data['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)));
                  artSnapshot.data!.docs.forEach((element) {
                    if (data['pendingApprovals'].contains(element.id)) {
                      //WIDGET: name of pending artwork
                      arts.add(Text(element.get('name')));
                      //WIDGET: approve button
                      arts.add(TextButton(
                        child: const Text("Approve"),
                        onPressed: () {
                          approveArt(data['name'], element.id);
                        },
                      ));
                      //WIDGET: reject button
                      arts.add(TextButton(
                        child: const Text("Reject"),
                        onPressed: () {
                          rejectArt(data['name'], element.id);
                        },
                      ));
                    }
                  });
                  //return a column with the list of widgets
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: arts,
                  );
                },
              );
            } else {
              //document has no pending approvals, but we still need a widget
              return const Text('');
            }
          }).toList(),
        );
      },
    );
  }
}
