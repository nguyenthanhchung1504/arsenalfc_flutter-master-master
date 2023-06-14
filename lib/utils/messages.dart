
import 'package:get/get.dart';

class Messages extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'vi_VI': {
      KeyString.KEY_NEWS : 'Tin tức',
      KeyString.KEY_LATEST : 'Mới nhất',
      KeyString.KEY_VIDEO : 'Video',
      KeyString.KEY_SCHEDULES : 'Lịch thi đấu',
      KeyString.KEY_RESULT : 'Kết quả',
      KeyString.KEY_RANK : 'Bảng xếp hạng',
      KeyString.KEY_DETAIL_NEW : 'Chi tiết bài viết',
      KeyString.KEY_DETAIL_VIDEO : 'Chi tiết video',
      KeyString.KEY_SUGGEST : 'Gợi ý dành cho bạn',
      KeyString.KEY_SEARCH_NEW : 'Tìm kiếm bài viết',
      KeyString.KEY_SEARCH_VIDEO : 'Tìm kiếm video',

    },
    'es_ES': {
      KeyString.KEY_NEWS : 'News',
      KeyString.KEY_LATEST : 'Latest',
      KeyString.KEY_VIDEO : 'Video',
      KeyString.KEY_SCHEDULES : 'Schedule',
      KeyString.KEY_RESULT : 'Result',
      KeyString.KEY_RANK : 'Rank football',
      KeyString.KEY_DETAIL_NEW : 'Article details',
      KeyString.KEY_DETAIL_VIDEO : 'Video details',
      KeyString.KEY_SUGGEST : 'Suggestions for you',
      KeyString.KEY_SEARCH_NEW : 'Search news',
      KeyString.KEY_SEARCH_VIDEO : 'Search videos',
    }
  };

}


class KeyString {
  static const KEY_NEWS = "news";
  static const KEY_LATEST = "latest";
  static const KEY_VIDEO = "video";
  static const KEY_SCHEDULES = "schedule";
  static const KEY_RESULT = "result";
  static const KEY_RANK = "rank";
  static const KEY_DETAIL_NEW = "detail_new";
  static const KEY_DETAIL_VIDEO = "detail_video";
  static const KEY_SUGGEST = "suggest";
  static const KEY_SEARCH_NEW = "search_new";
  static const KEY_SEARCH_VIDEO = "search_video";
}