

import 'package:get/get.dart';

import 'detail_new_controller.dart';
import 'detail_new_provider.dart';

class DetailNewBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailProvider());
    Get.put(DetailController(provider: Get.find()));
  }

}