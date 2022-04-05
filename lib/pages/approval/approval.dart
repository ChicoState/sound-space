import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          CustomText(
            text: "Approval Page",
          )
        ]);
  }
}
