import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> createApprovalInstance(String artName, String musicName) async {
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

    if (validUpload) {
      musicSnapshot = await FirebaseFirestore.instance
          .collection('MUSIC')
          .where(FieldPath.documentId, isEqualTo: musicID)
          .get();

      if (musicSnapshot.docs.isNotEmpty) {
        List tmp = musicSnapshot.docs.first.get('pendingApprovals');
        if (!tmp.contains(artID)) {
          tmp.add(artID);
          return music
              .doc(musicID)
              .update({'pendingApprovals': tmp})
              .then((value) =>
                  print("Added Approval( art: $artID , music: $musicID )"))
              .catchError((e) => print("ADDING ART ERROR: $e"));
        }
      }
    }
  }

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
