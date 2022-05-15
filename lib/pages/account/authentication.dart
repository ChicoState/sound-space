import 'package:flutter/material.dart';
import 'authentication_helpers.dart';

//this enum is just a state tracker - it tells certain processes where we are in the login process
enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
  //required vars
  const Authentication({
    Key? key,
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  }) : super(key: key);

  //type of required vars
  final ApplicationLoginState loginState;
  final String email; //nullable edit here (?)
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  @override //the whole widget is a giant switch statement
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        //give option to start login/signup process
        return Align(
            alignment: Alignment.center,
            child: Padding(
                padding: const EdgeInsets.all(8),
                // create elevated button to log in
                child: ElevatedButton(
                    onPressed: () {
                      startLoginFlow();
                    },
                    // define button theme and text
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    // add gradient to button
                    child: Ink(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Colors.purpleAccent,
                              Colors.blueAccent
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        // define container to hold the text button
                        child: Container(
                            width: 150,
                            height: 50,
                            alignment: Alignment.center,
                            child: const Text(
                              'Log In/Sign Up',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))))));
      case ApplicationLoginState.emailAddress:
        //need email, return relevant form
        return EmailForm(
            callback: (email) => verifyEmail(
                email, (e) => _showErrorDialog(context, 'Invalid email', e)));
      case ApplicationLoginState.password:
        //need password, return relevant form
        return PasswordForm(
          email: email, //nullable edit here (!)
          login: (email, password) {
            signInWithEmailAndPassword(email, password,
                (e) => _showErrorDialog(context, 'Failed to sign in', e));
          },
        );
      case ApplicationLoginState.register:
        //signup form has email, password, and name
        return RegisterForm(
          email: email, //nullable edit here (!)
          cancel: () {
            cancelRegistration();
          },
          registerAccount: (
            email,
            displayName,
            password,
          ) {
            registerAccount(
                email,
                displayName,
                password,
                (e) =>
                    _showErrorDialog(context, 'Failed to create account', e));
          },
        );
      case ApplicationLoginState.loggedIn:
        //give option to logout
        return Align(
            alignment: Alignment.center,
            child: ElevatedButton(
                onPressed: () {
                  signOut();
                },
                // define button theme and text
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                // add gradient to button
                child: Ink(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Colors.purpleAccent, Colors.blueAccent]),
                        borderRadius: BorderRadius.circular(20)),
                    // define container to hold the text button
                    child: Container(
                        width: 120,
                        height: 30,
                        alignment: Alignment.center,
                        child: const Text(
                          'Log Out',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )))));
      default:
        return Row(
          children: const [
            Text("Internal error, this shouldn't happen..."),
          ],
        );
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
