import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/controllers/menu_controller.dart';
import 'package:soundspace/controllers/navigation_controller.dart';
import 'package:soundspace/layout.dart';
import 'package:soundspace/pages/error/error_page.dart';
import 'package:soundspace/routing/routes.dart';

// firebase deps
import 'package:firebase_core/firebase_core.dart';
// generated by flutterfire cli for soundspace
import 'firebase_options.dart';
//auth dependency
import 'pages/account/applicationState.dart';

//flutter test
import 'package:flutter_test/flutter_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // initilization of Firebase app

  Get.put(MenuController());
  Get.put(NavigationController());
  //Alter runApp: call to ApplicationState() defines initial login state
  //Login state of a given browser *should* persist across visits
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: HomePageRoute,
      unknownRoute: GetPage(
          name: "/not-found",
          page: () => PageNotFound(),
          transition: Transition.fadeIn),
      getPages: [GetPage(name: rootRoute, page: () => SiteLayout())],
      debugShowCheckedModeBanner: false,
      title: "SoundScape",
      theme: ThemeData(
          scaffoldBackgroundColor: light,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
          }),
          primaryColor: Colors.blue),
    );
  }
}
