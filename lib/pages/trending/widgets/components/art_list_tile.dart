import 'package:flutter/material.dart';

Widget artListTile(
    {required String owner,
    required String cover,
    required VoidCallback onTap}) {
  return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 135,
            height: 135,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                image: DecorationImage(
                    image: NetworkImage(cover), fit: BoxFit.cover)),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(owner, textAlign: TextAlign.left),
          ])
        ],
      ));
}
