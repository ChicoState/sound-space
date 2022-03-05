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
        onTap: onTap,
        child: Container(
            height: 400,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      color: lightGrey.withOpacity(0.1),
                      blurRadius: 12)
                ],
                borderRadius: BorderRadius.circular(8)),
            child: Column(children: [
              Row(
                children: [
                  Expanded(child: Container(color: topColor, height: 5))
                ],
              ),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(
                        text: "$title\n",
                        style: TextStyle(
                            fontSize: 30,
                            color: isActive ? active : lightGrey)),
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
