//import 'dart:html';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewApprovals extends StatefulWidget {
  const ViewApprovals({Key? key}) : super(key: key);

  @override
  _ViewApprovalsState createState() => _ViewApprovalsState();
}

class _ViewApprovalsState extends State<ViewApprovals> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _musicStream = FirebaseFirestore.instance
        .collection('MUSIC')
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _musicStream,
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
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            if (data['pendingApprovals'].isNotEmpty) {
              /*return ListTile(
                title: Text(data['name']),
                subtitle: Text(data['url']),
              );*/
              List<Widget> arts = [];
              arts.add(Text(
                data['name'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ));
              data['pendingApprovals'].forEach((element) {
                arts.add(Text(element));
              });
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: arts,
              );
            } else {
              return const Text('nothing');
            }
          }).toList(),
        );
      },
    );
  }
}
