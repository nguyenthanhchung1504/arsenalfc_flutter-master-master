import 'package:arsenalfc_flutter/ui/detailplayer/detail_player_provider.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';

import '../../model/players/PlayerList.dart';
import '../../model/players/PlayerModel.dart';

class DetailPlayerController extends GetxController{
  final DetailPlayerProvider provider;

  DetailPlayerController({required this.provider});
  PlayerList playerModel = PlayerList();

  @override
  void onInit() {
    super.onInit();
    var argument = Get.arguments as List<dynamic>;
    if (argument.isNotEmpty) {
      argument.forEach((element) {
        if (element is PlayerList) {
          playerModel = element;
        }
      });
    }
  }

  String getCurrentYear(){

    if(playerModel.birthday?.isNullOrBlank == true){
      return "";
    }

    var yearBirthday = playerModel.birthday?.split(",").lastOrNull;
    DateTime dateTime = DateTime.now();
    return (dateTime.year - int.parse(yearBirthday ?? "0")).toString();
  }
}