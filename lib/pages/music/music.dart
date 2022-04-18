import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//to properly use ApplicationState context
import 'package:soundspace/pages/account/applicationState.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/pages/account/authentication.dart';
//to redirect to login page (currently "Account")
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';

import 'stream_builder.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageImpl createState() => _MusicPageImpl();
}

class _MusicPageImpl extends State<MusicPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => Scaffold(
              // positionals
              // if (appState.loginState ==
              //     ApplicationLoginState.loggedIn) ...[
              body: YTStreamBuilder(),
              // [ else ...[
              //   body: Text("please login"),
              // ],
            ));
  }
}
