import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

// firebase deps
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'yt_player.dart';

class MusicPage extends StatelessWidget {
  MusicPage({Key? key}) : super(key: key);

  CollectionReference music = FirebaseFirestore.instance.collection('MUSIC');
  final String documentId = '24tDc8GfTnmMqUozX3rd'; // CHANGE
  // TODO
  // change to query snapshot

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: music.doc(documentId).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> ds) {
        if (ds.hasError) {
          // catch errors
          return Text('FIRESTORE ERROR');
        }

        if (ds.hasData && !ds.data!.exists) {
          // document does not exists
          return Text('404 MUSIC DOES NOT EXIST');
        }

        if (ds.connectionState == ConnectionState.done) {
          // have good data from doc = documentId
          Map<String, dynamic> data = ds.data!.data() as Map<String, dynamic>;
          return MaterialApp(
            title: 'Music Player',
            theme: ThemeData(
              brightness: Brightness.dark,
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.black,
            ),
            debugShowCheckedModeBanner: false,
            home: YtPlayer(data: data), // passive passthrough of data
          );
        }
        return Text('loading');
      },
    );
  }
}
