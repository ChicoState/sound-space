import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

// firebase deps
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageHandler extends StatefulWidget {
  const ImageHandler({Key? key}) : super(key: key);

  @override
  _ImageHandlerState createState() => _ImageHandlerState();
}

//url validator
bool validateUrl(String? value) {
  String pattern =
      r'(^https://[a-zA-z/[.com,.edu,.gov,.org,.net]?]*)'; // NEEDS UPDATING LATER
  RegExp regExp = new RegExp(pattern);
  if (value == null || !regExp.hasMatch(value)) {
    // failed validation
    return false;
  }
  // passed validation
  return true;
}

// This widget is tracking its own state
class _ImageHandlerState extends State<ImageHandler> {
  // instance of our firestore database that should be type safe
  CollectionReference urls = FirebaseFirestore.instance.collection('art-urls');

  // contains input of controlled text field
  final _urlController = TextEditingController();
  final _nameController = TextEditingController();

  Future<void> addUrl(String url, String name) {
    return urls
        .add({'name': name, 'url': url})
        .then((value) => print("Added Art( name: $name , url: $url )"))
        .catchError((e) => print("ADDING ART ERROR: $e"));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          // TextFeild
          TextFormField(
              controller: _urlController,
              decoration: InputDecoration(
                hintText: 'Insert url Here',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              validator: (val) {
                if (validateUrl(val)) {
                  return null;
                }
                return 'Please enter a valid url';
              }),
          TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Insert name Here',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(20.0),
              ),
              validator: (val) {
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
                // UNVALIDATED, THIS DATA IS NOT CHECKED
                if (validateUrl(_urlController.text)) {
                  // passed
                  String _url =
                      _urlController.text; // this will act as our collected url
                  String _name = _nameController.text;
                  addUrl(_url, _name);
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing data')));
                }
                // failed
                Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter valid data')));
              },
            ),
          ),
        ],
      ), // Column
    );
  }
}
