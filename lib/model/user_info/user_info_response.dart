import 'user_data.dart';

class UserInfoResponse {
  UserInfoResponse({
      this.resultCode, 
      this.message, 
      this.success, 
      this.serverMessage, 
      this.userData,});

  UserInfoResponse.fromJson(dynamic json) {
    resultCode = json['ResultCode'];
    message = json['Message'];
    success = json['Success'];
    serverMessage = json['ServerMessage'];
    userData = json['Data'] != null ? UserData.fromJson(json['Data']) : null;
  }
  int? resultCode;
  String? message;
  bool? success;
  UserData? userData;
  dynamic serverMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResultCode'] = resultCode;
    map['Message'] = message;
    map['Success'] = success;
    map['ServerMessage'] = serverMessage;
    if (userData != null) {
      map['Data'] = userData?.toJson();
    }
    return map;
  }

}