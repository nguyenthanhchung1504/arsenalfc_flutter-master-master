import 'package:arsenalfc_flutter/ui/changeprofile/change_profile_controller.dart';
import 'package:arsenalfc_flutter/ui/changeprofile/change_profile_provider.dart';
import 'package:get/get.dart';

class ChangeProfileBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChangeProfileProvider());
    Get.put(ChangeProfileController(provider: Get.find()));
  }

}