// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:soundspace/pages/trending/widgets/art_card.dart';
import 'package:soundspace/pages/trending/widgets/music_card.dart';
import 'package:soundspace/pages/trending/widgets/video_card.dart';

// each card is inside its own dart file, which will need to be customized once
// backend for accessing is set up.

class TrendingPage extends StatelessWidget {
  const TrendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      // create container for page background
      body: Container(
          height: _height,
          width: _width,
          decoration: BoxDecoration(
            // set gradient background colors
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.purple.shade100, Colors.blue.shade100]),
          ),
          // Create appbar and tabbar for navigation / display
          child: DefaultTabController(
              length: 3, // define 3 tabs
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0, // hide shadow
                      titleSpacing: 0,
                      bottom: PreferredSize(
                        preferredSize: Size.fromRadius(14), // add padding
                        child: TabBar(
                          // create navigation
                          unselectedLabelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                              // define box for tabbar navigation
                              gradient: LinearGradient(colors: [
                                Colors.purpleAccent,
                                Colors.blueAccent
                              ]),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.black),
                          tabs: [
                            // Define tabs with title and icons
                            Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Music",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                icon: Icon(Icons.music_note_outlined)),
                            Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Videos",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                icon: Icon(Icons.videocam_outlined)),
                            Tab(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("Art",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ),
                                icon: Icon(Icons.brush_outlined)),
                          ],
                        ),
                      ),
                      automaticallyImplyLeading: false),
                  body: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    // define each page view
                    children: [
                      // Music trending card
                      Padding(
                          // add padding to each side
                          padding: EdgeInsets.fromLTRB(
                              _width / 12,
                              _height / 20,
                              _width / 12,
                              _height / 20), // left, top, right, bottom
                          child: const MusicCard(title: "Music")),
                      // Video trending card
                      Padding(
                          // add padding to each side
                          padding: EdgeInsets.fromLTRB(_width / 12,
                              _height / 20, _width / 12, _height / 20),
                          child: const VideoCard(title: "Videos")),
                      // Art trending card
                      Padding(
                          // add padding to each side
                          padding: EdgeInsets.fromLTRB(_width / 12,
                              _height / 20, _width / 12, _height / 20),
                          child: const ArtCard(title: "Art"))
                    ],
                  )))),
    );
  }
}
