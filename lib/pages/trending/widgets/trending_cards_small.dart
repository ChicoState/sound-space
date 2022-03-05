import 'package:flutter/material.dart';
import 'package:soundspace/pages/trending/widgets/info_card_small.dart';

class TrendingCardsSmall extends StatelessWidget {
  const TrendingCardsSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
        height: 400,
        child: Column(
          children: [
            InfoCardSmall(
                title: "Music",
                value: "Add songs here",
                isActive: true,
                onTap: () {}),
            SizedBox(width: _width / 64),
            InfoCardSmall(
                title: "Videos", value: "Add videos here", onTap: () {}),
            SizedBox(width: _width / 64),
            InfoCardSmall(title: "Art", value: "Add here here", onTap: () {}),
            SizedBox(width: _width / 64),
          ],
        ));
  }
}
