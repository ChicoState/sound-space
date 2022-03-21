import 'package:flutter/material.dart';
import 'package:soundspace/pages/trending/widgets/info_card.dart';

class TrendingCardsSmall extends StatelessWidget {
  const TrendingCardsSmall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InfoCard(title: "Music", topColor: Colors.green, onTap: () {}),
          const SizedBox(height: 12),
          InfoCard(title: "Videos", topColor: Colors.red, onTap: () {}),
          const SizedBox(height: 12),
          InfoCard(title: "Art", topColor: Colors.blue, onTap: () {})
        ],
      ),
    );
  }
}
