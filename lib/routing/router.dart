import 'package:flutter/material.dart';
import 'package:soundspace/pages/music/music.dart';
import 'package:soundspace/pages/overview/overview.dart';
import 'package:soundspace/pages/youtube/youtube.dart';
import 'package:soundspace/routing/routes.dart';

// possible routes to widgets
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case OverViewPageRoute:
      return _getPageRoute(OverViewPage());
    case YouTubePageRoute:
      return _getPageRoute(YouTubePage());
    case MusicPageRoute:
      return _getPageRoute(MusicPage());
    default:
      return _getPageRoute(OverViewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
