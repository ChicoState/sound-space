import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'applicationState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'url_info.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Check status of authentication
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  //display user's name and uploads
                  Text(
                      "Welcome, ${FirebaseAuth.instance.currentUser!.displayName}"),
                  const UrlInfo(query: 'ART'),
                  const UrlInfo(query: 'MUSIC'),
                  const UrlInfo(query: 'VIDEO'),
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
              signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
              cancelRegistration: appState.cancelRegistration,
              registerAccount: appState.registerAccount,
              signOut: appState.signOut,
            ),
          ),
        ],
      ),
    );
  }
}
