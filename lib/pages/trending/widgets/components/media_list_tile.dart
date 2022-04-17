import 'package:flutter/material.dart';

Widget mediaListTile(
    {required String title,
    required String singer,
    required String cover,
    required VoidCallback onTap}) {
  return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    image: DecorationImage(image: NetworkImage(cover))),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title,
                    style: const TextStyle(fontSize: 14.0),
                    textAlign: TextAlign.left),
                const SizedBox(height: 5.0),
                Text(singer,
                    style:
                        const TextStyle(color: Colors.black54, fontSize: 14.0),
                    textAlign: TextAlign.left)
              ])
            ],
          )));
}
