import 'package:flutter/material.dart';

import 'valid.dart';

// firebase deps
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MusicForm extends StatefulWidget {
  const MusicForm({Key? key}) : super(key: key);

  @override
  _MusicFormState createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {
  // private vars
  final _formKey = GlobalKey<FormState>();

  CollectionReference music = FirebaseFirestore.instance.collection('MUSIC');

  // contains input of controlled text field
  final _urlController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> addUrl(String url, String name) {
    // firebase fxn for writing new documents to a collection
    var user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      //this *should* never run because of the if/else in upload.dart
      print("ERROR: image_handler upload - User should not be null");
    }
    return music
        // all documents must be added in json format "key : value"
        .add({'name': name, 'url': url, 'user': user.hashCode})
        // .then is for any console output mostly for testing
        .then((value) => print("Added MUSIC( name: $name , url: $url )"))
        // catch any possible errors
        .catchError((e) => print("ADDING MUSIC ERROR: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          // TextFeild for url
          TextFormField(
              controller: _urlController,
              decoration: const InputDecoration(
                hintText: 'Insert url Here',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              validator: (val) {
                //validate url
                if (validateUrl(val)) {
                  return null;
                }
                return 'Please enter a valid url';
              }),
          // TextFeild for name
          TextFormField(
              controller: _nameController, //  field handler
              decoration: const InputDecoration(
                hintText: 'Insert name Here',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              validator: (val) {
                //make sure name is not null
                if (val != null) {
                  return null;
                }
                return 'Please enter a name';
              }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // validates that url is correct before ultimately adding anything to db
                if (validateUrl(_urlController.text)) {
                  // passed
                  String _url =
                      _urlController.text; // this will act as our collected url
                  String _name = _nameController.text;
                  addUrl(_url, _name); // values are added to db here
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing data')));
                } else {
                  // failed
                  // msg for user to change entered data
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter valid data')));
                }
                // clears text fields no matter the case
                _urlController.clear();
                _nameController.clear();
              },
            ),
          ),
        ],
      ), // Column
    );
  }
}
