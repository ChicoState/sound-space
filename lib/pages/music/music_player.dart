import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:soundspace/pages/music/media_display.dart';
import 'package:soundspace/pages/visuals/visuals.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  var curSong = ValueNotifier<String>(''); // hold current song title
  bool isVisible = true; // used to determine widget visibility

  //params for search bar
  String searchKey = ''; // used for msuic search bar
  Future<QuerySnapshot> musicQuery =
      FirebaseFirestore.instance.collection('MUSIC').get();

  // initial youtube video (need to change to first value in musicQuery -> i.e. first song on list)
  String initYTvid =
      "https://www.youtube.com/watch?v=jte7I4BO0WQ"; // temporary holder

  late YoutubePlayerController _controller; // define youtube video controller

  @override
  void initState() {
    // initial state of video player
    super.initState();
    _controller = YoutubePlayerController(
      // video player settings
      initialVideoId:
          YoutubePlayerController.convertUrlToId(initYTvid)!, // extracting key
      params: const YoutubePlayerParams(
        autoPlay: true,
        showControls: false,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
  } // initstate

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height; // page height
    //double _width = MediaQuery.of(context).size.width; // page height
    return Column(children: <Widget>[
      Center(
          // define youtube player
          child: SizedBox(
        height: _height / 3.5,
        child: SizedBox(
          height: _height / 4,
          child: YoutubePlayerControllerProvider(
              controller: _controller,
              child: YoutubePlayerIFrame(
                controller: _controller,
              )),
        ),
      )),
      // Button to route user to visuals page
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      fullscreenDialog: false,
                      builder: (context) => VisualPage(curSong: curSong)));
              setState(() {
                isVisible = true; // change page visibility
              });
            },
            // define button to navigate from art back to music list
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
                      'View Art',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )))),
      ),
      // Build Music List
      Container(
        // Search Bar for music list
        margin: const EdgeInsets.fromLTRB(32, 24, 32, 24),
        child: TextField(
            controller: TextEditingController(),
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Song Title",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.purple))),
            onSubmitted: (value) {
              //rebuild the FutureBuilder below w/ updated music query
              setState(() {
                searchKey = value;
                musicQuery = FirebaseFirestore.instance
                    .collection('MUSIC')
                    .where('name', isGreaterThanOrEqualTo: searchKey)
                    .where('name', isLessThan: searchKey + 'z')
                    .get();
              });
            }),
      ),
      Expanded(
          // Music List
          child: FutureBuilder<QuerySnapshot>(
              future: musicQuery,
              //convert documents into a list
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  //pass data to customListTile
                  return ListView.builder(
                      itemCount: documents.length,
                      itemBuilder: ((context, index) => mediaList(
                          onTap: () {
                            curSong.value = documents[index].id;
                            // Update video being played to the clicked song
                            _controller.load(
                                YoutubePlayerController.convertUrlToId(
                                    documents[index]['url'])!);
                            setState(() {
                              isVisible = false; // change page visibility
                            });
                          },
                          title: documents[index]['name'],
                          singer: documents[index]['user'], //email for now
                          cover: documents[index]['url'])));
                } else {
                  return const Text("Error");
                }
              }))
    ]);
  }
}
