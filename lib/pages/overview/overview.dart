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

// This widget is tracking its own state
class _ImageHandlerState extends State<ImageHandler> {
  // private vars
  final _formKey = GlobalKey<FormState>();

  CollectionReference urls = FirebaseFirestore.instance.collection(
      'art-urls'); // instance of our firestore database that should be type safe

  final _urlController =
      TextEditingController(); // contains input of controlled text field

  //url validator
  String validateUrl(String? value) {
    String pattern =
        r'(^https://[a-zA-z/[.com,.edu,.gov,.org,.net]?]*)'; // NEEDS UPDATING LATER
    RegExp regExp = new RegExp(pattern);
    if (value == null || !regExp.hasMatch(value)) {
      return "Please input a valid URL";
    }
    return value;
  }

  Future<void> addUrl(String url) {
    return urls
        .add({'name': 'test', 'url': url})
        .then((value) => print("Added Art: $url"))
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
              hintText: 'Insert Text Here',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (String? value) {
              return validateUrl(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
                // UNVALIDATED, THIS DATA IS NOT CHECKED
                String _url =
                    _urlController.text; // this will act as our collected url
                addUrl(_url);
              },
            ),
          ),
        ],
      ), // Column
    );
  }
}

class OverViewPage extends StatelessWidget {
  OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageHandler();
  }
}
