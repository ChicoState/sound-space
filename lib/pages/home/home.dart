import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/pages/account/account.dart';
import 'package:soundspace/widgets/custom_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.purple.shade100, Colors.blue.shade100]),
              // borderRadius: BorderRadius.circular(8)
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: _width / 16),
                Container(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                            text: "Welcome to",
                            size: 35,
                            color: Color.fromARGB(255, 77, 77, 77)),
                        const CustomText(
                            text: "SoundSpace",
                            size: 100,
                            weight: FontWeight.bold)
                      ]),
                ),
                SizedBox(width: _width / 16),
                Container(
                    child: AnimatedTextKit(animatedTexts: [
                  RotateAnimatedText("Discover",
                      textStyle: const TextStyle(
                          fontSize: 42, color: Color.fromARGB(255, 77, 77, 77)),
                      duration: const Duration(milliseconds: 2000)),
                  RotateAnimatedText("Upload",
                      textStyle: const TextStyle(
                          fontSize: 42, color: Color.fromARGB(255, 77, 77, 77)),
                      duration: const Duration(milliseconds: 2000)),
                  RotateAnimatedText("Compete",
                      textStyle: const TextStyle(
                          fontSize: 42, color: Color.fromARGB(255, 77, 77, 77)),
                      duration: const Duration(milliseconds: 2000)),
                  RotateAnimatedText("Enjoy",
                      textStyle: const TextStyle(
                          fontSize: 42, color: Color.fromARGB(255, 77, 77, 77)),
                      duration: const Duration(milliseconds: 2000)),
                ], repeatForever: true))
              ],
            )),
        floatingActionButton: Padding(
            padding: const EdgeInsets.all(8),
            child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => AccountPage()));
                },
                label: const CustomText(text: "Log In", size: 14),
                icon: const Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                ),
                backgroundColor: Colors.white)),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop);
  }
}
