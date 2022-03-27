import 'package:flutter/material.dart';
//import 'package:soundspace/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'authentication.dart';
import 'applicationState.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:soundspace/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UrlInfo extends StatefulWidget {
  const UrlInfo({Key? key}) : super(key: key);
  @override
  _UrlInfoState createState() => _UrlInfoState();
}

class _UrlInfoState extends State<UrlInfo> {
  final Stream<QuerySnapshot> _urlStream = FirebaseFirestore.instance
      .collection('art-urls')
      .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _urlStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['url']),
            );
          }).toList(),
        );
      },
    );
  }
}

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
                  Text("${FirebaseAuth.instance.currentUser!.displayName}"),
                  UrlInfo(),
                  /*FutureBuilder<DocumentSnapshot>(
                      future: urls.doc('hczyKXEGjqMUff5lHrgb').get(),
                      builder: (BuildContext context,
                          AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("Something went wrong");
                        }
                        if (snapshot.hasData && !snapshot.data!.exists) {
                          return Text("Document does not exist");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          return Text("url: ${data['url']}");
                        }
                        return Text("Loading");
                      }),*/
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
