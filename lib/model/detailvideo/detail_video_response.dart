import 'data_detail_video_model.dart';

class DetailVideoResponse {
  DetailVideoResponse({
      this.resultCode, 
      this.message, 
      this.success, 
      this.serverMessage, 
      this.data,});

  DetailVideoResponse.fromJson(dynamic json) {
    resultCode = json['ResultCode'];
    message = json['Message'];
    success = json['Success'];
    serverMessage = json['ServerMessage'];
    if (json['Data'] != null) {
      data = [];
      json['Data'].forEach((v) {
        data?.add(DataDetailVideoModel.fromJson(v));
      });
    }
  }
  int? resultCode;
  String? message;
  bool? success;
  dynamic serverMessage;
  List<DataDetailVideoModel>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResultCode'] = resultCode;
    map['Message'] = message;
    map['Success'] = success;
    map['ServerMessage'] = serverMessage;
    if (data != null) {
      map['Data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}