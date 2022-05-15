import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/pages/music/url_handler.dart';
import 'package:soundspace/pages/music/cover_display.dart';

import 'yt_player.dart';
import 'url_key_handler.dart';

class VisualPage extends StatefulWidget {
  const VisualPage({Key? key, required this.curSong}) : super(key: key);
  final ValueNotifier<String> curSong;

  @override
  State<VisualPage> createState() => _VisualPageState();
}

class _VisualPageState extends State<VisualPage> {
  final List<String> data = [
    "https://www.youtube.com/watch?v=bx-0YlFprqc",
    "https://www.youtube.com/watch?v=_hHwz1UWJmI"
  ];

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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blueAccent, Colors.blue.shade200]),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(_width / 20, _height / 20,
                  _width / 20, _height / 20), // left, top, right, bottom
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
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
                    children: [
                      const SizedBox(height: 15),
                      // YouTube Player
                      SizedBox(
                        child: YtPlayer(data: urlKeyFinder(data)),
                        height: 320,
                        width: 450,
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        // Define art list (associated with the current song being played)
                        child: Padding(
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            child: ValueListenableBuilder<String>(
                                valueListenable: widget.curSong,
                                builder: (_, value, __) {
                                  return FutureBuilder<QuerySnapshot>(
                                      future: FirebaseFirestore.instance
                                          .collection('ART')
                                          .where('approvedFor',
                                              arrayContains: value)
                                          .get(),
                                      //convert documents into a list
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final List<DocumentSnapshot>
                                              documents = snapshot.data!.docs;
                                          //pass data to artListTile
                                          return ListView.builder(
                                              itemCount: documents.length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: ((context, index) =>
                                                  albumArt(
                                                      onTap: () {
                                                        // Enlarge photos to full view when clicked
                                                        String img =
                                                            documents[index]
                                                                ['url'];
                                                        if (documents[index]
                                                            ['isVideo']) {
                                                          img =
                                                              "https://i.ytimg.com/vi/${urlKey(img)}/hqdefault.jpg";
                                                        }
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                fullscreenDialog:
                                                                    false,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return Scaffold(
                                                                      body:
                                                                          GestureDetector(
                                                                    // add padding so images don't go to very edge
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              14),
                                                                      child: Center(
                                                                          child: Hero(
                                                                        // image animation when opening/closing
                                                                        tag:
                                                                            'imageHero',
                                                                        child: ClipRRect(
                                                                            // add slight border to images
                                                                            borderRadius: BorderRadius.circular(6),
                                                                            child: Image.network(
                                                                              // show clicked image
                                                                              img,
                                                                              fit: BoxFit.fill,
                                                                            )),
                                                                      )),
                                                                    ),
                                                                    onTap: () {
                                                                      // return to art card
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                  ));
                                                                }));
                                                      },
                                                      cover: documents[index]
                                                          ['url'],
                                                      isVideo: documents[index]
                                                          ['isVideo'])));
                                        } else {
                                          return const Text("No art yet!");
                                        }
                                      });
                                })),
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          // define button to navigate back to music page
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
                                  height: 35,
                                  width: 100,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Go Back',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )))),
                      const SizedBox(height: 15)
                    ],
                  )))),
    );
  }
}
