import 'data_recomment_news.dart';

class RecommendNewsResponse {
  RecommendNewsResponse({
      this.resultCode, 
      this.message, 
      this.success, 
      this.serverMessage, 
      this.data,});

  RecommendNewsResponse.fromJson(dynamic json) {
    resultCode = json['ResultCode'];
    message = json['Message'];
    success = json['Success'];
    serverMessage = json['ServerMessage'];
    data = json['Data'] != null ? DataRecommendNews.fromJson(json['Data']) : null;
  }
  int? resultCode;
  String? message;
  bool? success;
  dynamic serverMessage;
  DataRecommendNews? data;

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