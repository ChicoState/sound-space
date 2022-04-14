import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*  Currently, this is just a text form that takes the name of an art and music document
 *  This assumes the "name" field is unique, which is not necessarily true
 *  The form also silently fails if the names are not found or the artwork is not the user's
 *  I want to replace this with a list of the user's artworks and a button to select for approval,
 *  But that has a number of complications and will come at a later date
 */

class ApprovalRequestForm extends StatefulWidget {
  const ApprovalRequestForm({Key? key}) : super(key: key);

  @override
  _ApprovalRequestFormState createState() => _ApprovalRequestFormState();
}

class _ApprovalRequestFormState extends State<ApprovalRequestForm> {
  CollectionReference music = FirebaseFirestore.instance.collection('MUSIC');
  final _formKey =
      GlobalKey<FormState>(debugLabel: '_ApprovalRequestFormState');
  final _musicNameController = TextEditingController();
  final _artNameController = TextEditingController();

  //verify art and music names and create pending approval
  Future<void> createApprovalInstance(String artName, String musicName) async {
    //find the art document with matching name
    bool validUpload = true;
    QuerySnapshot artSnapshot = await FirebaseFirestore.instance
        .collection('ART')
        .where('name', isEqualTo: artName)
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    String artID = "";
    if (artSnapshot.docs.isNotEmpty) {
      artID = artSnapshot.docs.first.id;
    } else {
      validUpload = false;
    }

    //find the music document with matching name
    QuerySnapshot musicSnapshot = await FirebaseFirestore.instance
        .collection('MUSIC')
        .where('name', isEqualTo: musicName)
        .get();
    String musicID = "";
    if (musicSnapshot.docs.isNotEmpty) {
      musicID = musicSnapshot.docs.first.id;
    } else {
      validUpload = false;
    }

    //only update approval state if both documents were found
    if (validUpload) {
      musicSnapshot = await FirebaseFirestore.instance
          .collection('MUSIC')
          .where(FieldPath.documentId, isEqualTo: musicID)
          .get();

      if (musicSnapshot.docs.isNotEmpty) {
        //pull the lists from FireStore
        List pending = musicSnapshot.docs.first.get('pendingApprovals');
        List approved = musicSnapshot.docs.first.get('approvals');
        //prevent duplicates in pending/approved lists
        if (!pending.contains(artID) && !approved.contains(artID)) {
          pending.add(artID);
          return music
              .doc(musicID)
              .update({'pendingApprovals': pending})
              .then((value) =>
                  print("Added Approval( art: $artID , music: $musicID )"))
              .catchError((e) => print("ADDING ART ERROR: $e"));
        }
      }
    }
  }

  //build the form
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Submit your art for approval'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //form item for art name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _artNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your artwork',
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Enter the name of the artwork you would like approved';
                      }
                      return null;
                    },
                  ),
                ),
                //form item for music name
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: _musicNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter music to be approved for',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter the name of the song or video you would like to be approved for';
                      }
                      return null;
                    },
                  ),
                ),
                //submit button, calls createApprovalInstance()
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            createApprovalInstance(_artNameController.text,
                                _musicNameController.text);
                          }
                          _artNameController.clear();
                          _musicNameController.clear();
                        },
                        child: const Text('Submit'),
                      ),
                      const SizedBox(width: 30),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
