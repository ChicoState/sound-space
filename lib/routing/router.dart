import 'package:flutter/material.dart';
import 'package:soundspace/pages/account/account.dart';
import 'package:soundspace/pages/approval/approval.dart';
import 'package:soundspace/pages/home/home.dart';
import 'package:soundspace/pages/tmp_music/tmp_music.dart';
import 'package:soundspace/pages/trending/trending.dart';
import 'package:soundspace/pages/upload/upload.dart';
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
      return _getPageRoute(TmpMusicPage()); // TMP MUSIC PAGE BEING USED
    case AccountPageRoute:
      return _getPageRoute(AccountPage());
    case ApprovalPageRoute:
      return _getPageRoute(ApprovalPage());
    default:
      return _getPageRoute(HomePage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
