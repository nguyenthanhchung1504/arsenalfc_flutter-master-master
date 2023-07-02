import 'package:arsenalfc_flutter/ui/signup/sign_up_controller.dart';
import 'package:arsenalfc_flutter/ui/signup/sign_up_provider.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpProvider());
    Get.put(SignUpController(provider: Get.find()));
  }

}