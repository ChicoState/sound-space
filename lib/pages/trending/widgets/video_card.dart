import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
//import 'package:soundspace/pages/trending/widgets/components/art_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soundspace/pages/trending/widgets/components/media_list_tile.dart';

class VideoCard extends StatelessWidget {
  const VideoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.66,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.grey.shade50, Colors.grey.shade200]),
                boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 6),
                      color: lightGrey.withOpacity(0.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              const SizedBox(height: 20),
              RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(children: [
                    TextSpan(
                        text: "Videos",
                        style: TextStyle(fontSize: 35, color: Colors.black87)),
                  ])),
              Expanded(
                  //fetch all 'art-url' documents
                  child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('ART')
                          .where('isVideo', isEqualTo: true)
                          .get(),
                      //convert documents into a list
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          //pass data to customListTile
                          return ListView.builder(
                              itemCount: documents.length,
                              itemBuilder: ((context, index) => mediaListTile(
                                  onTap: () {}, // used to navigate to page (?)
                                  title: documents[index]['name'],
                                  singer: documents[index]
                                      ['user'], //email for now
                                  cover: documents[index]['url'])));
                        } else {
                          return const Text("Error");
                        }
                      })),
              Container()
            ])),
      ),
    );
  }
}
