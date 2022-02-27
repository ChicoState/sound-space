import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

class ImageHandler extends StatefulWidget {
  const ImageHandler({Key? key}) : super(key: key);

  @override
  _ImageHandlerState createState() => _ImageHandlerState();
}

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
      child: Container(
        child: Center(
          child: Text(
            _isTapped ? 'Tapped' : 'unTapped',
            style: const TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _isTapped ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

class OverViewPage extends StatelessWidget {
  const OverViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Center(
    //     child: CustomText(
    //   text: "OverView Page",
    // ));
    return Row(
      children: [
        ImageHandler(),
        Text("Overview Page"),
      ],
    );
  }
}
