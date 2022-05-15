import 'package:flutter/material.dart';
import 'package:soundspace/pages/account/account.dart';
import 'package:soundspace/pages/approval/approval.dart';
//import 'package:soundspace/pages/music/music.dart';
import 'package:soundspace/pages/home/home.dart';
import 'package:soundspace/pages/music/music.dart';
import 'package:soundspace/pages/trending/trending.dart';
import 'package:soundspace/pages/upload/upload.dart';
import 'package:soundspace/routing/routes.dart';

// possible routes to widgets

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute(const HomePage());
    case trendingPageRoute:
      return _getPageRoute(const TrendingPage());
    case uploadPageRoute:
      return _getPageRoute(const UploadPage());
    case musicPageRoute:
      return _getPageRoute(const MusicPage()); // TMP MUSIC PAGE BEING USED
    case accountPageRoute:
      return _getPageRoute(const AccountPage());
    case approvalPageRoute:
      return _getPageRoute(const ApprovalPage());
    default:
      return _getPageRoute(const HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
