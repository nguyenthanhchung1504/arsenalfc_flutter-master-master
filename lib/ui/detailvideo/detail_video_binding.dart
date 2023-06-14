
import 'package:get/get.dart';

import 'detail_video_controller.dart';
import 'detail_video_provider.dart';

class DetailVideoBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailVideoProvider());
    Get.put(DetailVideoController(provider: Get.find()));
  }

}