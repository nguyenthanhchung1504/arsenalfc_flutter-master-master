
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_controller.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_provider.dart';
import 'package:get/get.dart';

class SearchVideoBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchVideoProviders());
    Get.put(SearchVideoController(providers: Get.find()));
  }

}