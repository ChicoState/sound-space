import 'package:flutter/material.dart';
import 'package:soundspace/helpers/local_navigator.dart';
import 'package:soundspace/widgets/side_menu.dart';

class SmallScreen extends StatelessWidget {
  const SmallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: SideMenu()),
        Expanded(flex: 5, child: Container(child: localNavigator()))
      ],
    ); // need to add drop down menu
  }
}
