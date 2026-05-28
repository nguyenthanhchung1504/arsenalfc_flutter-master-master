import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/firestore_schedule_repository.dart';
import 'schedules_controller.dart';

class SchedulesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => SchedulesController(
        scheduleRepository: FirestoreScheduleRepository(
          FirebaseFirestore.instance,
        ),
      ),
    );
  }
}
