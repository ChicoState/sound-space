import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomText(
      text: "Music Page",
    ));
  }
}
