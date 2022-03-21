import 'package:get/get.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/routing/routes.dart';
import 'package:flutter/material.dart';

// Uses GetX package (read on how to use this)
class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = HomePageDisplayName.obs;
  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isActive(String itemName) => activeItem.value == itemName;
  isHovering(String itemName) => hoverItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case HomePageDisplayName:
        return _customIcon(Icons.home_outlined, itemName);
      case TrendingPageDisplayName:
        return _customIcon(Icons.trending_up_outlined, itemName);
      case UploadPageDisplayName:
        return _customIcon(Icons.file_upload_outlined, itemName);
      case MusicPageDisplayName:
        return _customIcon(Icons.music_note_outlined, itemName);
      case AccountPageDisplayName:
        return _customIcon(Icons.people_alt_outlined, itemName);
      default:
        return _customIcon(Icons.exit_to_app, itemName);
    }
  }

  Widget _customIcon(IconData icon, String itemName) {
    if (isActive(itemName)) return Icon(icon, size: 22, color: dark);
    return Icon(icon, color: isHovering(itemName) ? dark : lightGrey);
  }
}
