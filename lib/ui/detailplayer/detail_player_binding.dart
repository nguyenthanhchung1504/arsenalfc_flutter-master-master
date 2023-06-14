import 'package:arsenalfc_flutter/ui/detailplayer/detail_player_controller.dart';
import 'package:arsenalfc_flutter/ui/detailplayer/detail_player_provider.dart';
import 'package:get/get.dart';

class DetailPlayerBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DetailPlayerProvider());
    Get.put(DetailPlayerController(provider: Get.find()));
  }

}