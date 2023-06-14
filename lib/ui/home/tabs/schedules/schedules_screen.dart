import 'package:arsenalfc_flutter/ui/home/tabs/schedules/fixture/fixture_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_controller.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/standing/standing_screen.dart';
import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:arsenalfc_flutter/utils/messages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'result/result_screen.dart';

class SchedulesScreen extends GetView<SchedulesController> {
  const SchedulesScreen({Key? key}) : super(key: key);


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
          body: DefaultTabController(
              length: 3,
              child: Container(
                color: const Color(AppColors.GRAY_LIGHT),
                child: Column(
                  children: [
                    Container(
                      child: TabBarViewLayout(),
                      color: Colors.white,
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
                        ))
                  ],
                ),
              ))),
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



