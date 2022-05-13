import 'package:flutter/material.dart';

// firebase deps
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'yt_player.dart';
import 'url_handler.dart';

class YTStreamBuilder extends StatefulWidget {
  const YTStreamBuilder({Key? key}) : super(key: key);

  @override
  _StreamBuidlerImpl createState() => _StreamBuidlerImpl();
}

class _StreamBuidlerImpl extends State<YTStreamBuilder> {
  final Stream<QuerySnapshot> music = FirebaseFirestore.instance
      .collection('ART')
      .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .where('isVideo', isEqualTo: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: music,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> qs) {
        if (qs.hasError) {
          // catch errors
          return const Text('FIRESTORE ERROR');
        }

        if (qs.connectionState == ConnectionState.waiting) {
          // server connection error
          return const Text('Loading...');
        }

        // urls is the string list of all urls
        List<String> urls = [];
        for (var d in qs.data!.docs) {
          urls.add(urlKey(d.get('url')!));
        }

        return MaterialApp(
          title: 'Music Player',
          theme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.black,
          ),
          debugShowCheckedModeBanner: false,
          home: YtPlayer(data: urls), // passive passthrough of data
        );
      },
    );
  }
}
