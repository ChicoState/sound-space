import 'package:flutter/material.dart';
import 'package:soundspace/pages/trending/widgets/info_card.dart';

class TrendingCardsMedium extends StatelessWidget {
  const TrendingCardsMedium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        children: [
          InfoCard(title: "Music", topColor: Colors.green, onTap: () {}),
          SizedBox(width: _width / 64),
          InfoCard(title: "Videos", topColor: Colors.red, onTap: () {}),
        ],
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          SizedBox(width: _width / 64),
          InfoCard(title: "Art", topColor: Colors.blue, onTap: () {})
        ],
      )
    ]);
  }
}
