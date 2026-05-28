import 'package:gooner_vietnam/ui/home/tabs/players/players_controller.dart';
import 'package:gooner_vietnam/ui/home/tabs/players/players_provider.dart';
import 'package:get/get.dart';

class PlayerBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlayerProvider());
    Get.put(PlayerController(provider: Get.find()));
  }

}