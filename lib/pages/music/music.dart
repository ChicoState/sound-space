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
        builder: (context, appState, _) => Column(
                // positionals
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (appState.loginState ==
                      ApplicationLoginState.loggedIn) ...[
                    YTStreamBuilder(),
                  ] else ...[
                    // not logged in, redirect to log in page
                    const Center(
                        child: Text(
                      'Please log in before uploading content',
                      style: TextStyle(fontStyle: FontStyle.italic),
                    )),
                    ElevatedButton(
                        onPressed: () {
                          menuController.changeActiveItemTo("Account");
                          if (ResponsiveWidget.isSmallScreen(context)) {
                            Get.back();
                          }
                          navigationController.navigateTo("/account");
                        },
                        // define button theme and text
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent, // hide large button
                            shadowColor:
                                Colors.transparent, // hide button shadow
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        // add gradient to button
                        child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.purpleAccent,
                                  Colors.blueAccent
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            // define container to hold the text button
                            child: Container(
                                height: 50,
                                width: 200,
                                alignment: Alignment.center,
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ))))
                  ],
                ]));
  }
}
