import 'package:flutter/material.dart';
//import 'package:soundspace/widgets/custom_text.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:google_fonts/google_fonts.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'applicationState.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Check status of authentication and print according statement
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loginState == ApplicationLoginState.loggedIn) ...[
                  const Text('Logged In'),
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
