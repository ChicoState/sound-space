import 'package:flutter/material.dart';
//import 'package:soundspace/widgets/custom_text.dart';
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
