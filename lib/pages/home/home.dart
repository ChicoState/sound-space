import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width; // page width
    double _height = MediaQuery.of(context).size.height; // page height
    return Scaffold(
        body: Container(
            // background color of homepage
            height: _height,
            width: _width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  // define gradient colors (top left to bottom right)
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple.shade100, Colors.blue.shade100]),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min, // center text on homepage
              children: [
                SizedBox(width: _width / 16), // small spacing on left side
                Container(
                  child: Column(
                      // define column for "Welcome to SoundSpace" header
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment:
                          CrossAxisAlignment.start, // left align text
                      children: [
                        SizedBox(
                            width: _width / 6, // width is 1/6 page
                            child: const FittedBox(
                              // dynamic sizing of text
                              fit: BoxFit.fitWidth, // fit to container width
                              child: Text(
                                "Welcome to",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 77, 77, 77)),
                              ),
                            )),
                        SizedBox(
                            width: _width / 2, // width is half page
                            child: const FittedBox(
                              // dynamic sizing of text
                              fit: BoxFit.fitWidth, // fit to container width
                              child: Text(
                                "SoundSpace",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ))
                      ]),
                ),
                SizedBox(width: _width / 16), // small spacing between text
                SizedBox(
                    width: _width / 8, // width is 1/8 of page
                    child: FittedBox(
                      // dynamic sizing of text
                      fit: BoxFit.fitWidth, // fit to width of container
                      child: AnimatedTextKit(animatedTexts: [
                        // define animated text
                        RotateAnimatedText("Discover",
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77)),
                            duration: const Duration(milliseconds: 2000)),
                        RotateAnimatedText("Upload",
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77)),
                            duration: const Duration(milliseconds: 2000)),
                        RotateAnimatedText("Compete",
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77)),
                            duration: const Duration(milliseconds: 2000)),
                        RotateAnimatedText("Enjoy",
                            textStyle: const TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77)),
                            duration: const Duration(milliseconds: 2000)),
                      ], repeatForever: true),
                    )),
                SizedBox(width: _width / 16), // small spacing on right side
              ],
            )),
        floatingActionButton: Padding(
            // define login button
            padding: const EdgeInsets.all(8), // add small padding
            child: FloatingActionButton.extended(
                onPressed: () {
                  // when pressed, navigate to account page
                  menuController.changeActiveItemTo("Account");
                  if (ResponsiveWidget.isSmallScreen(context)) {
                    Get.back();
                  }
                  navigationController.navigateTo("/account");
                },
                label:
                    const CustomText(text: "Log In", size: 14), // define text
                icon: const Icon(
                  Icons.people_alt_outlined, // define icon
                  color: Colors.black,
                ),
                backgroundColor: Colors.white)),
        floatingActionButtonLocation: FloatingActionButtonLocation
            .endTop); // set location of button (top right corner)
  }
}
