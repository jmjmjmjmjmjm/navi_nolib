import 'package:get/get.dart';

class Message extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'de_DE': {
          'best': 'BEST',
          'all': 'All',
          'day': 'Day',
          'week': 'Week',
          'month': 'Month'
        },
        'en_US': {
          'best': 'BEST',
          'all': 'All',
          'day': 'Day',
          'week': 'Week',
          'month': 'Month'
        },
        'ko_KR': {
          'best': '베스트',
          'all': '전체',
          'day': '일일베스트',
          'week': '주간베스트',
          'month': '주간베스트',
        }
      };
}
