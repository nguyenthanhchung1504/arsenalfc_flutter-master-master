
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_controller.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_provider.dart';
import 'package:get/get.dart';

class SchedulesBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleProvider());
    Get.put(SchedulesController(scheduleProvider: Get.find()));
  }

}