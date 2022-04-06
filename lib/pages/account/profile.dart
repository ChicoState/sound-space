import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'url_info.dart';

// Widget for user profile design layout
class ProfileLayout extends StatelessWidget {
  const ProfileLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: _height / 80,
        ),
        // define profile image (relace with back end to image)
        CircleAvatar(
          backgroundImage: const AssetImage("assets/images/blankProfile.jpeg"),
          radius: _height / 15,
        ),
        SizedBox(height: _height / 65),
        // Display user name
        Center(
          child: Text(
              "Welcome, ${FirebaseAuth.instance.currentUser!.displayName}"),
        ),
        SizedBox(height: _height / 65),
        // show user uploads
        Container(
            height: _height / 2.4,
            width: _width,
            // Create appbar and tabbar for navigation / display
            child: DefaultTabController(
                length: 4,
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
                                gradient: const LinearGradient(colors: [
                                  Colors.purpleAccent,
                                  Colors.blueAccent
                                ]),
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.black),
                            tabs: const [
                              // Define tabs with titles for each upload type
                              Tab(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Text("All Uploads",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )),
                              Tab(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Text("Music",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )),
                              Tab(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Text("Videos",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )),
                              Tab(
                                  child: Align(
                                alignment: Alignment.center,
                                child: Text("Art",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              )),
                            ],
                          ),
                        ),
                        automaticallyImplyLeading: false),
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      // define each page view (call UrlInfo for given type)
                      children: [
                        Column(
                          // All uploads
                          children: const [
                            UrlInfo(query: 'MUSIC'),
                            UrlInfo(query: 'ART')
                          ],
                        ),
                        const UrlInfo(query: 'MUSIC'), // music  uploads
                        const Text(
                            "add video url info here"), // videos  uploads
                        const UrlInfo(query: 'ART') // art uploads
                      ],
                    )))),
        SizedBox(height: _height / 70),
      ],
    );
  }
}
