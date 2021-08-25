class ContentModel {
  ContentModel(
      {this.title,
      this.subTitle,
      this.content,
      this.nick,
      this.type,
      this.place,
      this.code,
      this.regdt,
      this.snsType,
      this.snsUrl,
      this.photos,
      this.like,
      this.comment});

  String? title; // 제목
  String? subTitle; // 부제목
  String? content; // 내용
  String? nick; // 닉네임
  String? type; // 게시물 타입 (일일베스트 day, 주간베스트 week, 월간베스트 month)
  dynamic place; // 여행지
  String? code; // 예약 번호
  String? regdt; // 게시물 날짜
  String? snsType; // 소셜 타입
  String? snsUrl; // 소셜 링크
  List<String>? photos; // 사진
  int? like; // 좋아요
  int? comment; // 댓글

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
      title: json['title'],
      subTitle: json['subTitle'],
      content: json['content'],
      nick: json['nick'],
      type: json['type'],
      place: json['place'],
      code: json['code'],
      regdt: json['regdt'],
      snsType: json['snsType'],
      snsUrl: json['snsUrl'],
      photos: json['photos'],
      like: json['like'],
      comment: json['comment']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'subTitle': subTitle,
        'content': content,
        'nick': nick,
        'type': type,
        'place': place,
        'code': code,
        'regdt': regdt,
        'snsType': snsType,
        'snsUrl': snsUrl,
        'photos': photos,
        'like': like,
        'comment': comment
      };
}
