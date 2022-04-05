import 'package:flutter/material.dart';
//user authentication
import 'package:soundspace/pages/account/applicationState.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/pages/account/authentication.dart';
//routing
import 'package:get/get.dart';
import 'package:soundspace/constants/controllers.dart';
import 'package:soundspace/helpers/responsiveness.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationState>(
      builder: (context, appState, _) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          if (appState.loginState == ApplicationLoginState.loggedIn) ...[
            const Text("Approval Page"),
          ] else ...[
            const Text('Please log in to approve/request approval'),
            ElevatedButton(
              onPressed: () {
                menuController.changeActiveItemTo("Account");
                if (ResponsiveWidget.isSmallScreen(context)) {
                  Get.back();
                }
                navigationController.navigateTo("/account");
              },
              child: const Text('Log In'),
            )
          ],
        ],
      ),
    );
  }
}
