import 'package:flutter/material.dart';

class MusicForm extends StatefulWidget {
  const MusicForm({Key? key}) : super(key: key);

  @override
  _MusicFormState createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {
  // private vars
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          // TextField
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Music URL',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Plain Text';
              }
              // This is the actual return that will use 'value'
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if form is valid
                if (_formKey.currentState!.validate()) {
                  // form is invalid
                  //Proccess data
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ), // Column
    );
  }
}