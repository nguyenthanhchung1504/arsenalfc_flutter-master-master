import 'PlayerList.dart';

class PlayerModel {
  PlayerModel({
      this.playerList,});

  PlayerModel.fromJson(dynamic json) {
    if (json['PlayerList'] != null) {
      playerList = [];
      json['PlayerList'].forEach((v) {
        playerList?.add(PlayerList.fromJson(v));
      });
    }
  }
  List<PlayerList>? playerList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (playerList != null) {
      map['PlayerList'] = playerList?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}