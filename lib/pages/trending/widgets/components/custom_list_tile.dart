import 'package:flutter/material.dart';

Widget customListTile(
    {required String title,
    required String singer,
    required String cover,
    onTap}) {
  return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.0),
                image: DecorationImage(image: NetworkImage(cover))),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(children: [
            Text(title,
                style: TextStyle(fontSize: 14.0), textAlign: TextAlign.left),
            SizedBox(height: 5.0),
            Text(singer,
                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                textAlign: TextAlign.left)
          ])
        ],
      ));
}
