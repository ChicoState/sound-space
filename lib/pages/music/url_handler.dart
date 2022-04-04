// firebase deps
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Map<String, dynamic> url_handler() async {
  // this function will return query of all music attached to this user
  music = FirebaseFirestore.instance
      .collection('MUSIC')
      .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.email)
      .get();
}
