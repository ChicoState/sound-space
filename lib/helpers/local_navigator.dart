import 'package:flutter/widgets.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/routing/router.dart';
import 'package:soundspace/routing/routes.dart';

Navigator localNavigator() => Navigator(
      key: navigationController.navigationKey,
      initialRoute: homePageRoute,
      onGenerateRoute: generateRoute,
    );
