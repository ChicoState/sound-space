import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/pages/trending/widgets/trending_cards_medium.dart';
import 'package:soundspace/pages/trending/widgets/trending_cards_small.dart';
import 'widgets/trending_cards_large.dart';

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple.shade100, Colors.blue.shade100]),
            ),
            child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView(children: [
                      if (ResponsiveWidget.isLargeScreen(context) ||
                          ResponsiveWidget.isMediumScreen(context))
                        if (ResponsiveWidget.isCustomSize(context))
                          const TrendingCardsMedium()
                        else
                          const TrendingCardsLarge()
                      else
                        const TrendingCardsSmall()
                    ]))
                  ],
                ))));
  }
}
