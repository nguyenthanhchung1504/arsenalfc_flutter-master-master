

import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_controller.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_provider.dart';
import 'package:get/get.dart';

class VideosBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => VideosProvider());
    Get.put(VideoController(videosProvider: Get.find()));
  }

}