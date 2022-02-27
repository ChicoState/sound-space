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
  bool _isTapped = false;
  int _tapped = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // logic to change isTapped
          _isTapped = !_isTapped;
        });
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // This is teh button
          SizedBox(
            width: 100.0,
            height: 50.0,
            child: Container(
              child: Center(
                child: Text(
                  _isTapped ? 'Tapped' : 'unTapped',
                  style: const TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ),
              width: 100.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: _isTapped ? Colors.lightGreen[700] : Colors.grey[600],
              ),
            ),
          ),
          // THis is the picture
          SizedBox(
            width: 300.0,
            height: 200.0,
            child: Container(
                child: _isTapped
                    ? Image.asset('still_art/test_img.jpg')
                    : Text('Tap the button')),
          ),
        ],
      ),
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
