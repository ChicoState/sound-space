import 'package:flutter/material.dart';
import 'package:soundspace/widgets/custom_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomText(
      text: "Account Page",
    ));
  }
}
