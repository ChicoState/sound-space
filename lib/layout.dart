import 'package:flutter/material.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/widgets/large_screen.dart';
import 'package:soundspace/widgets/side_menu.dart';
import 'package:soundspace/widgets/small_screen.dart';

class SiteLayout extends StatelessWidget {
  SiteLayout({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const Drawer(child: SideMenu()),
      body: const ResponsiveWidget(
          largeScreen: LargeScreen(), smallScreen: SmallScreen()),
    );
  }
}
