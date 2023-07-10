import 'package:arsenalfc_flutter/ui/home/tabs/more/more_controller.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/more/more_provider.dart';
import 'package:get/get.dart';

class MoreBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MoreProvider());
    Get.put(MoreController(provider: Get.find()));
  }

}