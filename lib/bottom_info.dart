import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'model/example_model.dart';

class BottomInfo extends StatelessWidget {
  ContentModel model;
  BottomInfo({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20, top: 20, right: 20, left: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    '좋아요 ',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    model.like.toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(width: 25),
              Row(
                children: [
                  Text(
                    '댓글 ',
                    style: TextStyle(fontSize: 13),
                  ),
                  Text(
                    model.comment.toString(),
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottomIc('assets/ic_like.png', '좋아요'),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/profile.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20, left: 5),
                  child: Text('댓글달기',
                      style: GoogleFonts.notoSans(
                          fontSize: 13, fontWeight: FontWeight.bold)),
                ),
                bottomIc('assets/ic_share.png', '공유'),
                bottomIc('assets/ic_puton.png', '담기')
              ],
            ),
          )
        ],
      ),
    );
  }

  bottomIc(String img, String name) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Row(
        children: [
          Image.asset(img),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              name,
              style: GoogleFonts.notoSans(
                  fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
