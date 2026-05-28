import 'package:gooner_vietnam/ui/home/tabs/schedules/fixture/fixture_screen.dart';
import 'package:gooner_vietnam/ui/home/tabs/schedules/schedules_controller.dart';
import 'package:gooner_vietnam/ui/home/tabs/schedules/standing/standing_screen.dart';
import 'package:gooner_vietnam/utils/colors.dart';
import 'package:gooner_vietnam/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'result/result_screen.dart';

class SchedulesScreen extends GetView<SchedulesController> {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: Text(
              KeyString.KEY_SCHEDULES.tr,
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontFamily: "montserrat_black",
                  fontSize: 22,
                  color: Colors.black),
            ),
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }
            if (controller.errorMessage.value.isNotEmpty &&
                controller.listFixture.isEmpty &&
                controller.listResult.isEmpty &&
                controller.listStandings.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.cloud_off, size: 48),
                      const SizedBox(height: 12),
                      Text(
                        controller.errorMessage.value,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: controller.loadAll,
                        child: const Text('Thử lại'),
                      ),
                    ],
                  ),
                ),
              );
            }
            return DefaultTabController(
              length: 3,
              child: Container(
                color: const Color(AppColors.GRAY_LIGHT),
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: TabBarViewLayout(),
                    ),
                    Container(
                      color: const Color(AppColors.GRAY_LIGHT),
                      height: 1,
                    ),
                    const Flexible(
                      fit: FlexFit.loose,
                      child: TabBarView(
                        children: [
                          FixturesTab(),
                          ResultScreen(),
                          StandingScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}

class TabBarViewLayout extends GetView<SchedulesController> {
  @override
  Widget build(BuildContext context) {
    return  TabBar(
        padding: const EdgeInsets.all(8),
        indicatorColor: Colors.black,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        indicator: const ShapeDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            color: Colors.red),
        tabs: [
          Tab(
            height: 38,
            text: KeyString.KEY_SCHEDULES.tr,

          ),
          Tab(
            height: 38,
            text: KeyString.KEY_RESULT.tr,
          ),
          Tab(
            height: 38,
            text: KeyString.KEY_RANK.tr,
          )
        ]);
  }
}



