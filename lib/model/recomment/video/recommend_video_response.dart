
import 'package:arsenalfc_flutter/model/recomment/video/data_recommend_video.dart';

class RecommendVideoResponse {
  RecommendVideoResponse({
    this.resultCode,
    this.message,
    this.success,
    this.serverMessage,
    this.data,});

  RecommendVideoResponse.fromJson(dynamic json) {
    resultCode = json['ResultCode'];
    message = json['Message'];
    success = json['Success'];
    serverMessage = json['ServerMessage'];
    data = json['Data'] != null ? DataRecommendVideo.fromJson(json['Data']) : null;
  }
  int? resultCode;
  String? message;
  bool? success;
  dynamic serverMessage;
  DataRecommendVideo? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResultCode'] = resultCode;
    map['Message'] = message;
    map['Success'] = success;
    map['ServerMessage'] = serverMessage;
    if (data != null) {
      map['Data'] = data?.toJson();
    }
    return map;
  }

}