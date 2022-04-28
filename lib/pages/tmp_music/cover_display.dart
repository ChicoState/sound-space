import 'package:flutter/material.dart';
import 'package:soundspace/pages/music/url_handler.dart';

Widget albumArt(
    {required String cover,
    required VoidCallback onTap,
    required bool isVideo}) {
  if (isVideo) {
    cover = "https://i.ytimg.com/vi/${url_key(cover)}/hqdefault.jpg";
  }
  return InkWell(
      onTap: onTap,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 180,
              height: 180,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(cover, fit: BoxFit.fill)),
              decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(12, 5),
                        spreadRadius: 2.3,
                        blurRadius: 20),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-3, -4),
                        spreadRadius: -2,
                        blurRadius: 15)
                  ],
                  borderRadius: BorderRadius.circular(20)),
            )
          ]));
}
