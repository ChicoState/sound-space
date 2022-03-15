import 'package:flutter/material.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/widgets/large_screen.dart';
import 'package:soundspace/widgets/side_menu.dart';
import 'package:soundspace/widgets/small_screen.dart';
//import 'package:soundspace/widgets/top_nav.dart';

//nothing has actually changed in this file, but I did mess with it a lot
//  because the only way I could get the form to render was putting 'account.dart' code here
//import 'pages/account/account.dart';
//import 'pages/account/authentication.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';
//import 'firebase_options.dart';

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
