import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/routing/routes.dart';
import 'package:soundspace/widgets/custom_text.dart';
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
            if (ResponsiveWidget.isSmallScreen(context))
              Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Image.asset("assets/icons/logo.png")),
                    Flexible(
                        child: CustomText(
                            text: "SoundSpace",
                            size: 20,
                            weight: FontWeight.bold,
                            color: active)),
                    SizedBox(width: _width / 48)
                  ],
                ),
                const SizedBox(height: 40),
              ]),
            Divider(color: lightGrey.withOpacity(.1)),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: sideMenuItems
                  .map((itemName) => SideMenuItem(
                      itemName: itemName,
                      onTap: () {
                        if (!menuController.isActive(itemName)) {
                          menuController.changeActiveItemTo(itemName);
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo(itemName);
                        }
                      }))
                  .toList(),
            )
          ],
        ));
  }
}
