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

  /*  For future consideration:
   *  Maybe add another list of rejected approvals to MUSIC
   *  That way a user can't spam their art for approval
   */

  //remove the artwork from music's "approved" list and art's "approvedFor" list
  Future<void> rejectArt(String musicName, String artID) async {
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
      //read and update the list
      List<dynamic> approvals = musicSnapshot.docs.first.get('approvals');
      List<dynamic> approvedFor = artSnapshot.get('approvedFor');
      approvals.remove(artID);
      String musicID = musicSnapshot.docs.first.id;
      approvedFor.remove(musicID);
      //update the FireStore document
      artCollection
          .doc(artID)
          .update({'approvedFor': approvedFor})
          .then((value) => print(
              "(reject) Removed approval from ART ( art: $artID , music: $musicID )"))
          .catchError((e) => print("REMOVING APPROVAL ERROR: $e"));
      musicCollection
          .doc(musicID)
          .update({'approvals': approvals})
          .then((value) => print(
              "(reject) Removed approval from MUSIC ( art: $artID , music: $musicID )"))
          .catchError((e) => print("REMOVING APPROVAL ERROR: $e"));
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
            //check if the document has approvals
            if (data['approvals'].isNotEmpty) {
              //second StreamBuilder - tracks artworks - filters by approvals
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
                  //add title of the video (bolded)
                  arts.add(Text(data['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold)));
                  for (var element in artSnapshot.data!.docs) {
                    if (data['approvals'].contains(element.id)) {
                      //Add artwork and reject button in a Row
                      arts.add(Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(element.get('name')),
                            TextButton(
                                child: const Text('Reject'),
                                onPressed: () {
                                  rejectArt(data['name'], element.id);
                                }),
                          ]));
                    }
                  }
                  //return a column with the list of widgets
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: arts,
                  );
                },
              );
            } else {
              //document has no approvals, but we still need a widget
              return const Text('');
            }
          }).toList(),
        );
      },
    );
  }
}
