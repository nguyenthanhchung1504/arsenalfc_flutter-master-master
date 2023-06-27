
import 'package:arsenalfc_flutter/ui/signin/sign_in_controller.dart';
import 'package:arsenalfc_flutter/ui/signin/sign_in_provider.dart';
import 'package:get/get.dart';

class SignInBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignInProviders());
    Get.put(SignInController(providers: Get.find()));
  }

}