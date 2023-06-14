import 'package:arsenalfc_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../extension/extension.dart';
import '../schedules_controller.dart';

class FixturesTab extends GetView<SchedulesController> {
  const FixturesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.listFixture.isNotEmpty ? ListView.builder(
        itemCount: controller.listFixture.length,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16,top: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration:  const BoxDecoration(
                      gradient: LinearGradient(colors: [Color(AppColors.RED_LIGHT),Color(AppColors.RED)]),
                      image: DecorationImage(image: AssetImage("assets/images/ic_bg.png"),fit: BoxFit.cover)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Text(
                              "${StringDate.toDateServer(controller.listFixture.elementAt(index).fixture?.date ?? "", "dd/MM/yyyy")} - ${StringDate.toDateServer(controller.listFixture.elementAt(index).fixture?.date ?? "", "HH:mm")}",
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.white,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),
                            ),
                          ),
                          Positioned(
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      (controller.listFixture
                                          .elementAt(index)
                                          .league
                                          ?.name ??
                                          "")
                                          .toUpperCase(),
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: "montserrat_black",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10),
                                      textAlign: TextAlign.center,
                                    ),
                                  )))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              child: Column(
                                children: [
                                  ClipOval(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.white,
                                        child: Center(
                                          child: Image.network(
                                            controller.listFixture
                                                .elementAt(index)
                                                .teams
                                                ?.home
                                                ?.logo ??
                                                "",
                                            width: 45,
                                            height: 45,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(6),
                                    child: Text(controller.listFixture.elementAt(index).teams?.home?.name ?? "",
                                      style: const TextStyle(color: Colors.white,fontSize: 9,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),),
                                  )
                                ],
                              ),
                            ),
                          ),

                          Expanded(
                            child: Column(
                              children: [
                                Text("${controller.listFixture.elementAt(index).goals?.home ?? 0} - ${controller.listFixture.elementAt(index).goals?.away ?? 0}",
                                  style: const TextStyle(color: Colors.white,fontSize: 25,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),),

                                Container(
                                  padding: const EdgeInsets.only(left: 8,top: 8,right: 8,bottom: 24),
                                  child: Text(controller.listFixture.elementAt(index).fixture?.venue?.name ?? "",
                                    style: const TextStyle(color: Colors.white,fontSize: 12,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,),
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  ClipOval(
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        color: Colors.white,
                                        child: Center(
                                          child: Image.network(
                                            controller.listFixture
                                                .elementAt(index)
                                                .teams
                                                ?.away
                                                ?.logo ??
                                                "",
                                            width: 45,
                                            height: 45,
                                          ),
                                        ),
                                      )),
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 16),
                                    padding: const EdgeInsets.all(6),
                                    child: Text(controller.listFixture.elementAt(index).teams?.away?.name ?? "",
                                      style: const TextStyle(color: Colors.white,fontSize: 9,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),),
                                  )
                                ],
                              ),
                            ),
                          )

                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                        left: 16, top: 8, bottom: 8, right: 16),
                    child: Row(
                      children: [
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            Container(
                                padding:
                                const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  StringDate.toDateServer(
                                      controller.listFixture
                                          .elementAt(index)
                                          .fixture
                                          ?.date ??
                                          "",
                                      "dd/MM/yyyy"),
                                  style: const TextStyle(
                                      fontSize: 10, color: Colors.grey,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                StringDate.toDateServer(
                                    controller.listFixture
                                        .elementAt(index)
                                        .fixture
                                        ?.date ??
                                        "",
                                    "HH:mm"),
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Wrap(
                              direction: Axis.vertical,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        controller.listFixture
                                            .elementAt(index)
                                            .teams
                                            ?.home
                                            ?.logo ??
                                            "",
                                        width: 18,
                                        height: 18,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          controller.listFixture
                                              .elementAt(index)
                                              .teams
                                              ?.home
                                              ?.name ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        controller.listFixture
                                            .elementAt(index)
                                            .teams
                                            ?.away
                                            ?.logo ??
                                            "",
                                        width: 18,
                                        height: 18,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          controller.listFixture
                                              .elementAt(index)
                                              .teams
                                              ?.away
                                              ?.name ??
                                              "",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            child: Container(
                              child: Text(
                                (controller.listFixture.elementAt(index).league?.name ??
                                    "")
                                    .toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "montserrat_black",fontWeight: FontWeight.w400,
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                              alignment: Alignment.centerRight,
                            ))
                      ],
                    )),
              ),
            );
          }
        }) :
    Container(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/ic_no_data.png",width: 99,height: 116,),
          const Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              "Không có dữ liệu",
              style: TextStyle(fontSize: 12, color: Colors.grey,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}