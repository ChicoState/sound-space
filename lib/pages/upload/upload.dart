import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';
import 'music_handler.dart';
import 'image_handler.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ImageHandler(),
        MusicForm(),
      ],
    );
  }
}
