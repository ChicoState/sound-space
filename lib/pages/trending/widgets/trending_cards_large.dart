import 'package:flutter/material.dart';
import 'package:soundspace/pages/trending/widgets/info_card.dart';

class TrendingCardsLarge extends StatelessWidget {
  const TrendingCardsLarge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Row(children: [
      InfoCard(title: "Music", topColor: Colors.green, onTap: () {}),
      SizedBox(width: _width / 64),
      InfoCard(title: "Videos", topColor: Colors.red, onTap: () {}),
      SizedBox(width: _width / 64),
      InfoCard(title: "Art", topColor: Colors.blue, onTap: () {})
    ]);
  }
}
