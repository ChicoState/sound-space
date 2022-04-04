import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//called by AccountPage to display all the currently logged in user's uploads
//values are returned in a Column widget - can be formatted acordingly
class UrlInfo extends StatefulWidget {
  final String query;
  const UrlInfo({Key? key, required this.query}) : super(key: key);

  @override
  _UrlInfoState createState() => _UrlInfoState();
}

class _UrlInfoState extends State<UrlInfo> {
  @override
  Widget build(BuildContext context) {
    //filter uploads for only those matching user's email
    final Stream<QuerySnapshot> _urlStream = FirebaseFirestore.instance
        .collection(widget.query)
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();
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
