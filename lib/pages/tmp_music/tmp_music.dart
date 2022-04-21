import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/pages/tmp_music/music_player.dart';

class TmpMusicPage extends StatefulWidget {
  const TmpMusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageTMP createState() => _MusicPageTMP();
}

class _MusicPageTMP extends State<TmpMusicPage> {
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
                    // define container to hold music player
                    height: MediaQuery.of(context).size.height * 0.7,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.grey.shade50,
                              Colors.grey.shade200
                            ]),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 6),
                              color: lightGrey.withOpacity(0.1),
                              blurRadius: 12)
                        ],
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                        // add padding to each side
                        padding: EdgeInsets.fromLTRB(_width / 16, _height / 24,
                            _width / 16, _height / 24),
                        child: MusicPlayer())))));
  }
}
