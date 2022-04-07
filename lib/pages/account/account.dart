import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/pages/account/profile.dart';
import 'authentication.dart';
import 'applicationState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'url_info.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

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
                  // define container to hold upload prompts
                  height: MediaQuery.of(context).size.height * 0.66,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.grey.shade50, Colors.grey.shade200]),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 6),
                            color: lightGrey.withOpacity(0.1),
                            blurRadius: 12)
                      ],
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //Check status of authentication
                      Consumer<ApplicationState>(
                        builder: (context, appState, _) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (appState.loginState ==
                                ApplicationLoginState.loggedIn) ...[
                              // call profile layout widget
                              const ProfileLayout()
                            ] else ...[
                              const Text('Logged Out'),
                            ],
                          ],
                        ),
                      ),
                      Consumer<ApplicationState>(
                        //Authentication() handles all the login/logout/signup forms and logic
                        builder: (context, appState, _) => Authentication(
                          email: appState.email,
                          loginState: appState.loginState,
                          startLoginFlow: appState.startLoginFlow,
                          verifyEmail: appState.verifyEmail,
                          signInWithEmailAndPassword:
                              appState.signInWithEmailAndPassword,
                          cancelRegistration: appState.cancelRegistration,
                          registerAccount: appState.registerAccount,
                          signOut: appState.signOut,
                        ),
                      ),
                    ],
                  )))),
    );
  }
}
