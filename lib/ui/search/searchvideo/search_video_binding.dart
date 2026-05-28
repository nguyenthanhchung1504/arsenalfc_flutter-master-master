import 'package:get/get.dart';

import 'search_video_controller.dart';

class SearchVideoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SearchVideoController());
  }
}
