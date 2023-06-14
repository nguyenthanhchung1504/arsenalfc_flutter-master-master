
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../model/players/PlayerList.dart';
import '../../../../model/players/PlayerModel.dart';
import 'players_provider.dart';

class PlayerController extends GetxController{
  final PlayerProvider provider;
  PlayerController({required this.provider});


  List<PlayerList> listPlayers = [];
  PlayerModel playerModel = PlayerModel();

  RxInt indexItem = 0.obs;

  @override
  void onInit() {

    super.onInit();

    loadData();

  }

  void changeIndex(int index){
    indexItem.value = index;
    update();
  }



  Future<String> loadData() async{
    var data = await DefaultAssetBundle.of(Get.context!).loadString("assets/json/afc_arsenal.json");
    var response = json.decode(data);
    playerModel = PlayerModel.fromJson(response);
    listPlayers = playerModel.playerList ?? [];
    print(listPlayers.length);
    return "success";
  }


}