import 'package:flutter/material.dart';
import 'authenticationHelpers.dart';

//this enum is just a state tracker - it tells certain processes where we are in the login process
//I don't see any use in applying types to it, but maybe I'm missing your point?
//because the same effect could be reached with an integer 0-4 where 0=loggedOut, 1=emailAddress, etc.
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
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

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
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: TextButton(
                  child: const Text('Log In/Sign Up'),
                  onPressed: () {
                    startLoginFlow();
                  }),
            ),
          ],
        );
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
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: TextButton(
                child: const Text('LOGOUT'),
                onPressed: () {
                  signOut();
                },
              ),
            ),
          ],
        );
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
