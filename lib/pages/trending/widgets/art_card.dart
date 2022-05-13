import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/helpers/responsiveness.dart';
import 'package:soundspace/pages/trending/widgets/components/art_list_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArtCard extends StatelessWidget {
  const ArtCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //double _width = MediaQuery.of(context).size.width;
    //double _height = MediaQuery.of(context).size.height;
    return Expanded(
      child: InkWell(
        child: Container(
            // Set up card background color and shape
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
                        // title
                        text: "Art",
                        style: TextStyle(fontSize: 35, color: Colors.black87)),
                  ])),
              const SizedBox(height: 15),
              Expanded(
                  //fetch all 'art-url' documents
                  child: FutureBuilder<QuerySnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('ART')
                          .where('isVideo', isEqualTo: false)
                          .get(),
                      //convert documents into a list
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final List<DocumentSnapshot> documents =
                              snapshot.data!.docs;
                          //pass data to artListTile
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: // if small screen show 1 image, else show 2 per line
                                    (ResponsiveWidget.isSmallScreen(context)
                                        ? 1
                                        : 2),
                                childAspectRatio: 3 / 2, // scales spacing
                              ),
                              itemCount: documents.length,
                              itemBuilder: ((context, index) => artListTile(
                                  onTap: () {
                                    // Enlarge photos to full view when clicked
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            fullscreenDialog: false,
                                            builder: (BuildContext context) {
                                              return Scaffold(
                                                  body: GestureDetector(
                                                // add padding so images don't go to very edge
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(14),
                                                  child: Center(
                                                      child: Hero(
                                                    // image animation when opening/closing
                                                    tag: 'imageHero',
                                                    child: ClipRRect(
                                                        // add slight border to images
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                        child: Image.network(
                                                          // show clicked image
                                                          documents[index]
                                                              ['url'],
                                                          fit: BoxFit.fill,
                                                        )),
                                                  )),
                                                ),
                                                onTap: () {
                                                  // return to art card
                                                  Navigator.pop(context);
                                                },
                                              ));
                                            }));
                                  },
                                  owner: documents[index]['name'],
                                  cover: documents[index]['url'])));
                        } else {
                          return const Text("Error");
                        }
                      })),
            ])),
      ),
    );
  }
}
