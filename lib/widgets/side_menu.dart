import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/routing/routes.dart';
import 'package:soundspace/widgets/side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        color: light,
        child: ListView(
          children: [
            Divider(color: lightGrey.withOpacity(.1)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((item) => SideMenuItem(
                      itemName: item.name,
                      onTap: () {
                        if (!menuController.isActive(item.name)) {
                          menuController.changeActiveItemTo(item.name);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(item.route);
                        }
                      }))
                  .toList(),
            )
          ],
        ));
  }
}
