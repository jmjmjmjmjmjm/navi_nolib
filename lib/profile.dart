import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pla0823/model/example_model.dart';
import 'package:pla0823/webview_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Profile extends StatelessWidget {
  ContentModel model;
  Profile({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 13, 20, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                child: Image.asset('assets/profile.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  model.nick.toString(),
                  style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Text(
                time(model),
                style: GoogleFonts.notoSans(fontSize: 13),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Text(
              model.content.toString(),
              style: GoogleFonts.notoSans(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            model.place['title'],
            style:
                GoogleFonts.notoSans(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          MaterialButton(
            onPressed: () {
              Get.to(WebViewPage());
            },
            minWidth: 0.0,
            padding: EdgeInsets.zero,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Image.asset('assets/ic_instargram.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 1),
                  child: Text(
                    model.nick.toString(),
                    style: GoogleFonts.notoSans(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    '?????? ',
                    style: GoogleFonts.notoSans(fontSize: 13),
                  ),
                ),
                Text(
                  toLink(model.snsType.toString()) + ' ????????????',
                  style: GoogleFonts.notoSans(fontSize: 13),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Image.asset('assets/ic_newwin.png'),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  time(ContentModel model) {
    var day = model.regdt.toString().split('-'); // -??? ?????????
    var time = day[2].split(' '); // ???????????? ?????????
    var timeRe = int.parse(time[0]); // ??????/??????????????? int?????????
    if (timeRe > 12) (timeRe = timeRe % 12); // ??????/?????? ??????
    var watch = time[1].split(':'); // ??????
    var now = DateTime.now();
    var berlinWallFell = DateTime.parse(model.regdt.toString()); // ??????????????? ??????

    if (now.year - berlinWallFell.year < 1) {
      if (now.month - berlinWallFell.month < 1) {
        if (now.day - berlinWallFell.day < 1) {
          return (now.hour - berlinWallFell.hour).toString() + '?????? ???';
        }
        return (now.day - berlinWallFell.day).toString() + '??? ???';
      }
    } else {
      return (day[0] +
          '.' +
          day[1] +
          '.' +
          time[0] +
          (int.parse(watch[0]) < 12 ? ' ?????? ' : ' ?????? ') +
          timeRe.toString() +
          ':' +
          watch[1]);
    }
  }

  toLink(String title) {
    switch (title) {
      case 'naver':
        return '?????????';
      case 'google':
        return '??????';
      case 'facebook':
        return '????????????';
    }
  }
}
