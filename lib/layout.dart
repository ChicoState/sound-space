import 'package:flutter/material.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/widgets/large_screen.dart';
import 'package:soundspace/widgets/side_menu.dart';
import 'package:soundspace/widgets/small_screen.dart';
import 'package:soundspace/widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //appBar: topNavigationBar(context, scaffoldKey),
      drawer: Drawer(child: SideMenu()),
      body: ResponsiveWidget(
          largeScreen: LargeScreen(), smallScreen: SmallScreen()),
    );
  }
}
