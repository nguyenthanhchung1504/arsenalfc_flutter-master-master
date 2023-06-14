import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../extension/extension.dart';

class ResultScreen extends GetView<SchedulesController>{
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.listResult.isNotEmpty ? ListView.builder(
        itemCount: controller.listResult.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 8, left: 16, right: 16,top: index == 0 ? 16 : 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.only(
                      left: 16, top: 8, bottom: 8, right: 16),
                  child: Row(
                    children: [
                      Text(controller.listResult.elementAt(index).fixture?.status?.short ?? "",style: const TextStyle(fontSize: 13,color: Colors.black,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),),
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
                                      controller.listResult
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
                                        controller.listResult
                                            .elementAt(index)
                                            .teams
                                            ?.home
                                            ?.name ??
                                            "",
                                        style:  TextStyle(
                                            fontSize: 12,
                                            color: controller.isArsenal(controller.listResult.elementAt(index).teams?.home?.name) ? Colors.red : Colors.black,
                                            fontFamily: "montserrat_black",fontWeight: FontWeight.w400),
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
                                      controller.listResult
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
                                        controller.listResult
                                            .elementAt(index)
                                            .teams
                                            ?.away
                                            ?.name ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: controller.isArsenal(controller.listResult.elementAt(index).teams?.away?.name) ? Colors.red : Colors.black,
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
                      Container(
                        child: Wrap(
                          direction: Axis.vertical,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((controller.listResult.elementAt(index).goals?.home ?? 0).toString(),
                                style: TextStyle(fontSize: 13,
                                    color: controller.isArsenal(controller.listResult.elementAt(index).teams?.home?.name) ? Colors.red : Colors.black
                                    ,fontFamily: "montserrat_black",fontWeight: FontWeight.w400
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text((controller.listResult.elementAt(index).goals?.away ?? 0).toString(),
                                style: TextStyle(fontSize: 13,color: controller.isArsenal(controller.listResult.elementAt(index).teams?.away?.name) ? Colors.red : Colors.black
                                    ,fontFamily: "montserrat_black",fontWeight: FontWeight.w400
                                ),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          );
        })
    : Container(
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