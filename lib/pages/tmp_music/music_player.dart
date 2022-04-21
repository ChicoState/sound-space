import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/pages/tmp_music/cover_display.dart';
import 'package:soundspace/pages/tmp_music/media_display.dart';
import 'package:soundspace/pages/tmp_music/page_manager.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  late final PageManager _pageManager;

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height; // page height
    double _width = MediaQuery.of(context).size.width; // page height
    return Column(children: <Widget>[
      // Build image galley (horizontal)
      Container(
        height: _height / 3.2,
        child: ValueListenableBuilder<String>(
            valueListenable: _pageManager.curSong,
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        fullscreenDialog: false,
                                        builder: (BuildContext context) {
                                          return Scaffold(
                                              body: GestureDetector(
                                            // add padding so images don't go to very edge
                                            child: Padding(
                                              padding: const EdgeInsets.all(14),
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
                                                      documents[index]['url'],
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
                              cover: documents[index]['url'])));
                    } else {
                      return const Text("No art yet!");
                    }
                  });
            }),
      ),
      // Build Music Player
      Container(
        // Search Bar
        margin: const EdgeInsets.fromLTRB(32, 24, 32, 24),
        child: TextField(
          controller: TextEditingController(),
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: "Song Title",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.purple))),
          onChanged: searchMusic, // filter function
        ),
      ),
      Expanded(
          // Music List
          child: FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection('MUSIC')
                  .where('isVideo', isEqualTo: false)
                  .get(),
              //convert documents into a list
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  //pass data to customListTile
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: ((context, index) => mediaList(
                          onTap: () {
                            _pageManager.setSong(
                                documents[index]['url'], documents[index].id);
                          },
                          title: documents[index]['name'],
                          singer: documents[index]['user'], //email for now
                          cover: documents[index]['url'])));
                } else {
                  return const Text("Error");
                }
              })),
      ValueListenableBuilder<ProgressBarState>(
        // Music Controls (Slider, Pause/Play)
        valueListenable: _pageManager.progressNotifier,
        builder: (_, value, __) {
          return ProgressBar(
            progress: value.current,
            buffered: value.buffered,
            total: value.total,
            onSeek: _pageManager.seek,
          );
        },
      ),
      ValueListenableBuilder<ButtonState>(
        valueListenable: _pageManager.buttonNotifier,
        builder: (_, value, __) {
          switch (value) {
            case ButtonState.loading:
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 32.0,
                height: 32.0,
                child: const CircularProgressIndicator(),
              );
            case ButtonState.paused:
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 32.0,
                onPressed: _pageManager.play,
              );
            case ButtonState.playing:
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 32.0,
                onPressed: _pageManager.pause,
              );
          }
        },
      )
    ]);
  }
}

/*
  This function will filter the list based on the search words within
  the bar - needs to convert all titles to lower case, filter based on
  search criteria, and set the state. Below is a video that does something
  similar but not with firebase (just a locally stored list):
  https://www.youtube.com/watch?v=ZHdg2kfKmjI
*/
void searchMusic(String query) {}

/*
  Eventually we will need a function that can also filter the art/videos
  being displayed to only show things associated with that song (right now
  it's showing all uploaded art and no videos). Could possibly replace
  the above searchMusic to just a searchFilter function that does everything
  at once?
*/
