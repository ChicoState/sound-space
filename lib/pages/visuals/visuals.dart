import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/pages/music/url_handler.dart';
import 'package:soundspace/pages/tmp_music/cover_display.dart';

import 'yt_player.dart';
import 'url_key_handler.dart';

class VisualPage extends StatefulWidget {
  var curSong = ValueNotifier<String>('');

  VisualPage({Key? key, required this.curSong}) : super(key: key);

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
    return Center(
        child: Column(
      children: [
        const SizedBox(height: 15),
        // TODO YOUTUBE PLAYER HERE
        SizedBox(
          child: YtPlayer(data: url_key_finder(data)),
          height: 300,
        ),
        // YT player end
        const SizedBox(height: 15),
        Expanded(
          // Define art list (associated with the current song being played)
          child: ValueListenableBuilder<String>(
              valueListenable: widget.curSong,
              builder: (_, value, __) {
                return FutureBuilder<QuerySnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('ART')
                        .where('approvedFor', arrayContains: value)
                        .get(),
                    //convert documents into a list
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<DocumentSnapshot> documents =
                            snapshot.data!.docs;
                        //pass data to artListTile
                        return ListView.builder(
                            itemCount: documents.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) => albumArt(
                                onTap: () {
                                  // Enlarge photos to full view when clicked
                                  String img = documents[index]['url'];
                                  if (documents[index]['isVideo']) {
                                    img =
                                        "https://i.ytimg.com/vi/${url_key(img)}/hqdefault.jpg";
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          fullscreenDialog: false,
                                          builder: (BuildContext context) {
                                            return Scaffold(
                                                body: GestureDetector(
                                              // add padding so images don't go to very edge
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(14),
                                                child: Center(
                                                    child: Hero(
                                                  // image animation when opening/closing
                                                  tag: 'imageHero',
                                                  child: ClipRRect(
                                                      // add slight border to images
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                      child: Image.network(
                                                        // show clicked image
                                                        img,
                                                        fit: BoxFit.fill,
                                                      )),
                                                )),
                                              ),
                                              onTap: () {
                                                // return to art card
                                                Navigator.pop(context);
                                              },
                                            ));
                                          }));
                                },
                                cover: documents[index]['url'],
                                isVideo: documents[index]['isVideo'])));
                      } else {
                        return const Text("No art yet!");
                      }
                    });
              }),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            // define button to navigate back to music page
            style: ElevatedButton.styleFrom(
                primary: Colors.transparent, // hide large button
                shadowColor: Colors.transparent, // hide button shadow
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20))),
            // add gradient to button
            child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.purpleAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20)),
                // define container to hold the text button
                child: Container(
                    height: 35,
                    width: 100,
                    alignment: Alignment.center,
                    child: const Text(
                      'Go Back',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )))),
        const SizedBox(height: 15)
      ],
    ));
  }
}
