import 'package:flutter/material.dart';
import 'package:soundspace/pages/music/music.dart';
import 'package:soundspace/pages/home/home.dart';
import 'package:soundspace/pages/upload/upload.dart';
import 'package:soundspace/pages/trending/trending.dart';
import 'package:soundspace/routing/routes.dart';

// possible routes to widgets

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePageRoute:
      return _getPageRoute(HomePage());
    case TrendingPageRoute:
      return _getPageRoute(TrendingPage());
    case UploadPageRoute:
      return _getPageRoute(UploadPage());
    case MusicPageRoute:
      return _getPageRoute(MusicPage());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
