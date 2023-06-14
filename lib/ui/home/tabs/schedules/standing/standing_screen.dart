
import 'package:arsenalfc_flutter/ui/home/tabs/schedules/schedules_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class StandingScreen extends GetView<SchedulesController>{
  const StandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(18),
            color: Colors.white,
            child: const Text("Premier League",style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: "montserrat_black",fontWeight: FontWeight.w700),),
          ),
          Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children:  [
                SizedBox(

                  child: const Align(
                    alignment: Alignment.centerRight,
                    child:  Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text("#",style: TextStyle(fontSize: 12,color: Color(0xFF143872),fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 1/7 ,
                ),
                SizedBox(
                  child: const Text("Đội",style: TextStyle(fontSize: 12,color: Color(0xFF143872),fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
                  width: MediaQuery.of(context).size.width * 3/7,
                ),
                SizedBox(
                  child: const Text("Trận",style: TextStyle(fontSize: 12,color: Color(0xFF143872),fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
                SizedBox(
                  child: const Text("Hiệu số",style: TextStyle(fontSize: 12,color: Color(0xFF143872),fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
                SizedBox(
                  child: const Text("Điểm",style: TextStyle(fontSize: 12,color: Color(0xFF143872),fontFamily: "montserrat_black",fontWeight: FontWeight.w500),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
              ],
            ),
          ),

          Flexible(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.listStandings.value.length,
                  itemBuilder: (BuildContext context,int index){
                    return  Container(
                      margin: const EdgeInsets.only(bottom: 4,left: 18,right: 18),
                      decoration: BoxDecoration(
                        color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "") ? Colors.red : Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(8))
                      ),
                      height: 48,
                      child: Row(
                        children:  [
                          Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child:  Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Text((controller.listStandings.value.elementAt(index).rank ?? 0).toString(),
                                  style: TextStyle(fontSize: 12,
                                      color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "")  ? Colors.white : Colors.black
                                      ,fontFamily: "montserrat_black",fontWeight: FontWeight.w400
                                  ),),
                              ),
                            ),
                            width: (MediaQuery.of(context).size.width * 1/7) - 18 ,
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                CachedNetworkImage(imageUrl: controller.listStandings.value.elementAt(index).team?.logo ?? "",width: 20,height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5),
                                  child: Text(controller.listStandings.value.elementAt(index).team?.name ?? "",
                                    style: TextStyle(fontSize: 12,
                                        color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "")  ? Colors.white : Colors.black
                                        ,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text((controller.listStandings.value.elementAt(index).all?.played ?? 0).toString(),
                                style: TextStyle(fontSize: 12,color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "")  ? Colors.white : Colors.black,fontFamily: "montserrat_black",fontWeight: FontWeight.w400),),
                            ),
                            width: MediaQuery.of(context).size.width * 1/7,
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Text((controller.listStandings.value.elementAt(index).goalsDiff ?? 0).toString(),
                                style: TextStyle(fontSize: 12,color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "")  ? Colors.white : Colors.black
                                    ,fontFamily: "montserrat_black",fontWeight: FontWeight.w400
                                ),),
                            ),
                            width: MediaQuery.of(context).size.width * 1/7,
                          ),
                          SizedBox(
                            child: Text((controller.listStandings.value.elementAt(index).points ?? 0).toString(),
                              style: TextStyle(fontSize: 12,
                                  fontFamily: "montserrat_black",fontWeight: FontWeight.w700,
                                  color: controller.isArsenal(controller.listStandings.value.elementAt(index).team?.name ?? "")  ? Colors.white : Colors.black),),
                            width: (MediaQuery.of(context).size.width * 1/7) - 18 ,
                          ),
                        ],
                      ),
                    );
                  }
              )
          )

        ],
      ),
    );
  }

}

class RowStanding extends GetView<SchedulesController>{
  const RowStanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: controller.listStandings.value.length,
        itemBuilder: (BuildContext context,int index){
          return  Container(
            height: 48,
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              children:  [
                SizedBox(

                  child: Align(
                    alignment: Alignment.centerRight,
                    child:  Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text((controller.listStandings.value.elementAt(index).rank ?? 0).toString(),style: const TextStyle(fontSize: 12,color: Colors.black),),
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 1/7 ,
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Image.network(controller.listStandings.value.elementAt(index).team?.logo ?? "",width: 24,height: 24,),
                      Text(controller.listStandings.value.elementAt(index).team?.name ?? "",style: const TextStyle(fontSize: 12,color: Colors.black),)
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 3/7,
                ),
                SizedBox(
                  child: Text((controller.listStandings.value.elementAt(index).all?.played ?? 0).toString(),style: const TextStyle(fontSize: 12,color: Colors.black),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
                SizedBox(
                  child: Text((controller.listStandings.value.elementAt(index).goalsDiff ?? 0).toString(),style: const TextStyle(fontSize: 12,color: Colors.black),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
                SizedBox(
                  child: Text((controller.listStandings.value.elementAt(index).points ?? 0).toString(),style: const TextStyle(fontSize: 12,color: Colors.black),),
                  width: MediaQuery.of(context).size.width * 1/7,
                ),
              ],
            ),
          );
        }
    );
  }

}


