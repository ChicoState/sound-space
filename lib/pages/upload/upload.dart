import 'package:flutter/material.dart';
//import 'package:soundspace/widgets/custom_text.dart';
import 'music_handler.dart';
import 'image_handler.dart';
//to properly use ApplicationState context
import 'package:soundspace/pages/account/applicationState.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/pages/account/authentication.dart';
//to redirect to login page (currently "Account")
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
        builder: (context, appState, _) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  const ImageHandler(),
                  const MusicForm(),
                ] else ...[
                  const Text('Please log in before uploading content'),
                  ElevatedButton(
                    onPressed: () {
                      menuController.changeActiveItemTo("Account");
                      if (ResponsiveWidget.isSmallScreen(context)) {
                        Get.back();
                      }
                      navigationController.navigateTo("Account");
                    },
                    child: const Text('Log In'),
                  )
                ],
              ],
            ));
  }
}
