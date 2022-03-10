import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CustomText(
            text: "Music Page",
          )
        ]);
  }
}
