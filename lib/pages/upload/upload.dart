import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
//import 'package:soundspace/widgets/custom_text.dart';
import 'music_handler.dart';
import 'image_handler.dart';
//to properly use ApplicationState context
import 'package:soundspace/pages/account/applicationState.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/pages/account/authentication.dart';
//to redirect to login page (currently "Account")
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

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
                      // give slight gradient background to box
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
                  child: Padding(
                      // pad left and right side of upload text box's (don't go to end of container)
                      padding: EdgeInsets.only(
                          left: _width / 25, right: _width / 25),
                      child: Consumer<ApplicationState>(
                          builder: (context, appState, _) => Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  if (appState.loginState ==
                                      ApplicationLoginState.loggedIn) ...[
                                    // image upload text and box
                                    const Text("Image Upload",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(height: _height / 70),
                                    const ImageHandler(),
                                    SizedBox(height: _height / 26),
                                    // music upload text and box
                                    const Text("Music Upload",
                                        style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(height: _height / 70),
                                    const MusicForm(),
                                  ] else ...[
                                    // not logged in, redirect to log in page
                                    const Text(
                                        'Please log in before uploading content'),
                                    ElevatedButton(
                                      onPressed: () {
                                        menuController
                                            .changeActiveItemTo("/account");
                                        if (ResponsiveWidget.isSmallScreen(
                                            context)) {
                                          Get.back();
                                        }
                                        navigationController
                                            .navigateTo("/account");
                                      },
                                      child: const Text('Log In'),
                                    )
                                  ],
                                ],
                              )))),
            )));
  }
}
