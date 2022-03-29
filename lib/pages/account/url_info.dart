import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//sort of a placeholder class, proof of concept w/ dynamic firebase reads
//called by AccountPage to display all the currently logged in user's uploads
class UrlInfo extends StatefulWidget {
  const UrlInfo({Key? key}) : super(key: key);
  @override
  _UrlInfoState createState() => _UrlInfoState();
}

class _UrlInfoState extends State<UrlInfo> {
  //filter art uploads for only those matching user's email
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
          //turn a collection of documents into a list and display as ListTile widgets
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
