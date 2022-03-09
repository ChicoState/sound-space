import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/widgets/custom_text.dart';

/*
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
*/

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: _width / 16),
        const CustomText(
            text: "SoundSpace", size: 100, weight: FontWeight.bold),
        SizedBox(width: _width / 16),
        Container(
            child: AnimatedTextKit(animatedTexts: [
          RotateAnimatedText("Discover",
              textStyle: const TextStyle(fontSize: 50, color: Colors.blue),
              duration: const Duration(milliseconds: 2000)),
          RotateAnimatedText("Upload",
              textStyle: const TextStyle(fontSize: 50, color: Colors.purple),
              duration: const Duration(milliseconds: 2000)),
          RotateAnimatedText("Compete",
              textStyle: const TextStyle(fontSize: 50, color: Colors.blue),
              duration: const Duration(milliseconds: 2000)),
          RotateAnimatedText("Enjoy",
              textStyle: const TextStyle(fontSize: 50, color: Colors.purple),
              duration: const Duration(milliseconds: 2000)),
        ], repeatForever: true))
      ],
    );
  }
}
