import 'package:gooner_vietnam/ui/changeprofile/change_profile_controller.dart';
import 'package:gooner_vietnam/ui/changeprofile/change_profile_provider.dart';
import 'package:get/get.dart';

class ChangeProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeProfileProvider());
    Get.put(ChangeProfileController(provider: Get.find()));
  }

}