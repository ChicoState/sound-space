import 'package:flutter/material.dart';
import 'package:soundspace/helpers/local_navigator.dart';
import 'package:soundspace/widgets/side_menu.dart';

class LargeScreen extends StatelessWidget {
  const LargeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: const SideMenu()),
        Expanded(flex: 5, child: localNavigator())
      ],
    );
  }
}