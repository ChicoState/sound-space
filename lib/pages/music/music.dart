import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
//to properly use ApplicationState context
import 'package:soundspace/pages/account/application_state.dart';
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
    double _width = MediaQuery.of(context).size.width; // page width
    double _height = MediaQuery.of(context).size.height; // page height
    return Scaffold(
      body: Container(
          // background color of upload page
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                // define gradient colors (top left to bottom right)
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple.shade100, Colors.blue.shade100]),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(_width / 10, _height / 13,
                  _width / 10, _height / 13), // left, top, right, bottom
              child: Container(
                  // define container to hold upload prompts
                  height: MediaQuery.of(context).size.height * 0.66,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey.shade50, Colors.grey.shade200]),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.1),
                            blurRadius: 12)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Check status of authentication
                      Consumer<ApplicationState>(
                        builder: (context, appState, _) => Column(
                          // ListView makes page scrollable
                          children: [
                            if (appState.loginState ==
                                ApplicationLoginState.loggedIn) ...[
                              // call profile layout widget
                              SizedBox(
                                width: _width = MediaQuery.of(context)
                                    .size
                                    .width, // page width
                                height: _height =
                                    MediaQuery.of(context).size.height * 0.8,
                                child: const YTStreamBuilder(),
                              )
                            ] else ...[
                              const Center(
                                  child: Text(
                                'Please log in before uploading content',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              )),
                              SizedBox(height: _height / 34),
                              ElevatedButton(
                                  onPressed: () {
                                    menuController
                                        .changeActiveItemTo("Account");
                                    if (ResponsiveWidget.isSmallScreen(
                                        context)) {
                                      Get.back();
                                    }
                                    navigationController.navigateTo("/account");
                                  },
                                  // define button theme and text
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors
                                          .transparent, // hide large button
                                      shadowColor: Colors
                                          .transparent, // hide button shadow
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20))),
                                  // add gradient to button
                                  child: Ink(
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Colors.purpleAccent,
                                                Colors.blueAccent
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      // define container to hold the text button
                                      child: Container(
                                          height: 50,
                                          width: 200,
                                          alignment: Alignment.center,
                                          child: const Text(
                                            'Log In',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ))))
                            ],
                          ],
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
