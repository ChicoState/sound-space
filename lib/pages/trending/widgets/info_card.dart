import 'package:flutter/material.dart';
import 'package:soundspace/constants/style.dart';
import 'package:soundspace/constants/music_list.dart';
import 'package:soundspace/pages/trending/widgets/components/custom_list_tile.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final Color topColor;
  final bool isActive;
  final VoidCallback onTap;

  const InfoCard(
      {Key? key,
      required this.title,
      required this.topColor,
      this.isActive = false,
      required this.onTap})
      : super(key: key);

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
                  text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n",
                        style: const TextStyle(
                            fontSize: 35, color: Colors.black87)),
                  ])),
              Expanded(
                  child: ListView.builder(
                      itemCount: musicList.length,
                      itemBuilder: ((context, index) => customListTile(
                          onTap: () {},
                          title: musicList[index]['title'],
                          singer: musicList[index]['singer'],
                          cover: musicList[index]['coverUrl'])))),
              Container()
            ])),
      ),
    );
  }
}
