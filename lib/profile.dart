import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pla0823/model/example_model.dart';

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
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Image.asset('assets/ic_instargram.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, right: 1),
                  child: Text(
                    model.nick.toString(),
                    style: GoogleFonts.notoSans(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 1),
                  child: Text(
                    '님의 ',
                    style: GoogleFonts.notoSans(fontSize: 13),
                  ),
                ),
                Text(
                  toLink(model.snsType.toString()) + ' 구경가기',
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
    var day = model.regdt.toString().split('-'); // -로 나누기
    var time = day[2].split(' '); // 띄어쓰기 나누기
    var timeRe = int.parse(time[0]); // 오전/오후를위해 int값으로
    if (timeRe > 12) (timeRe = timeRe % 12); // 오전/오후 계산
    var watch = time[1].split(':'); // 시간
    var now = DateTime.now();
    var berlinWallFell = DateTime.parse(model.regdt.toString()); // 올린게시글 날짜

    if (now.year - berlinWallFell.year < 1) {
      if (now.month - berlinWallFell.month < 1) {
        if (now.day - berlinWallFell.day < 1) {
          return (now.hour - berlinWallFell.hour).toString() + '시간 전';
        }
        return (now.day - berlinWallFell.day).toString() + '일 전';
      }
    } else {
      return (day[0] +
          '.' +
          day[1] +
          '.' +
          time[0] +
          (int.parse(watch[0]) < 12 ? ' 오전 ' : ' 오후 ') +
          timeRe.toString() +
          ':' +
          watch[1]);
    }
  }

  toLink(String title) {
    switch (title) {
      case 'naver':
        return '네이버';
      case 'google':
        return '구글';
      case 'facebook':
        return '페이스북';
    }
  }
}
