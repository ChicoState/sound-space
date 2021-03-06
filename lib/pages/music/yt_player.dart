import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
// Using Youtube Player Iframe project for easier use of
// official iFrame Player API

import "volume_ui.dart";
import "play_pause_button.dart";

class YtPlayer extends StatefulWidget {
  // this value is a final const List of const String
  final List<String> data;

  const YtPlayer({Key? key, required this.data})
      : super(
            key:
                key); // recieving of data, 'required' b/c of dynamic properties.
  @override
  _YtPlayerState createState() => _YtPlayerState();
}

class _YtPlayerState extends State<YtPlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    // initial state of video player
    super.initState();
    _controller = YoutubePlayerController(
      // video player settings
      initialVideoId: widget.data[0], // extracting key
      params: YoutubePlayerParams(
        playlist: widget.data, // takes a list of video id's
        startAt: const Duration(minutes: 1, seconds: 36),
        showControls: false,
        showFullscreenButton: true,
        desktopMode: false,
        privacyEnhanced: true,
        useHybridComposition: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      log('Entered Fullscreen');
    };
    _controller.onExitFullscreen = () {
      log('Exited Fullscreen');
    };
  } // initstate

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (kIsWeb && constraints.maxWidth > 800) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: player),
                  SizedBox(
                    width: 400,
                    child: SingleChildScrollView(
                      // // custom controls for video currently disabled
                      child: Controls(),
                    ),
                  ),
                ],
              );
            }
            return ListView(
              children: [
                Stack(
                  // this stack effects the video player itself
                  children: [
                    player,
                    Positioned.fill(
                      child: YoutubeValueBuilder(
                        controller: _controller,
                        builder: (context, value) {
                          return AnimatedCrossFade(
                            firstChild: const SizedBox.shrink(),
                            secondChild: Material(
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      YoutubePlayerController.getThumbnail(
                                        videoId:
                                            _controller.params.playlist.first,
                                        quality: ThumbnailQuality.medium,
                                      ),
                                    ),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            crossFadeState: value.isReady
                                ? CrossFadeState.showFirst
                                : CrossFadeState.showSecond,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const Controls(),
              ],
            );
          },
        ),
      ),
    );
  } // widget

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class Controls extends StatelessWidget {
  ///
  const Controls({Key? key}) : super(key: key);
  // all custom controls for the player go in here

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _space,
          VolumeSlider(),
          _space,
          const PlayPauseButtonBar(),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}
