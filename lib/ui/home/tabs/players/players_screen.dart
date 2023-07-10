import 'package:arsenalfc_flutter/routes/routes_const.dart';
import 'package:arsenalfc_flutter/ui/detailplayer/detail_player_screen.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/players/players_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pageviewj/pageviewj.dart';

class PlayerScreen extends GetView<PlayerController> {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title : Obx(() => Text(controller.listPlayers.elementAt(controller.indexItem.value).name ?? "",
            style: const TextStyle(color: Colors.red,fontSize: 18,fontWeight: FontWeight.bold,  fontFamily: "montserrat_black",),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: GestureDetector(
            child:
            const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
            onTap: () {
              Get.back();
            },
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 80),
          child: PageViewJ(
              itemCount: controller.listPlayers.length,
              modifier: const Modifier(viewportFraction: .89),
              transform: RotateTransform(),
              onPageChanged: (index) {
                controller.changeIndex(index);
              },
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(AppConst.DETAIL_PLAYER,arguments: [controller.listPlayers.elementAt(index)]);
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 50,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 130,
                        height: MediaQuery.of(context).size.height / 2 - 50,
                        child: Image.asset(
                          "assets/images/${controller.listPlayers.elementAt(index).imageNew ?? ""}",
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                );
              }),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}
