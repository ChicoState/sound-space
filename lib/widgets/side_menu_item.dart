import 'package:flutter/material.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/widgets/horizontal_menu_item.dart';
import 'package:soundspace/widgets/vertical_menu_item.dart';

class SideMenuItem extends StatelessWidget {
  final String itemName;
  final VoidCallback onTap;
  const SideMenuItem({Key? key, required this.itemName, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(itemName: itemName, onTap: onTap);
    }
    return HorizontalMenuItem(itemName: itemName, onTap: onTap);
  }
}
