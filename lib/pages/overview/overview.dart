import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';


class ImageHandler extends StatefulWidget {
  const ImageHandler({Key? key}) : super(key: key);

  @override
  _ImageHandlerState createState() => _ImageHandlerState();
}

// This widget is tracking its own state
class _ImageHandlerState extends State<ImageHandler> {
  // private vars
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: <Widget>[
          // TextFeild
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Insert Text Here',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.all(20.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Text';
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

class OverViewPage extends StatelessWidget {
  OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageHandler();
  }
}
