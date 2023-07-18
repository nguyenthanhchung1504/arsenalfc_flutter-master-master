class UploadAvatarResponse {
  UploadAvatarResponse({
      this.resultCode, 
      this.message, 
      this.success, 
      this.serverMessage, 
      this.data,});

  UploadAvatarResponse.fromJson(dynamic json) {
    resultCode = json['ResultCode'];
    message = json['Message'];
    success = json['Success'];
    serverMessage = json['ServerMessage'];
    data = json['Data'];
  }
  int? resultCode;
  String? message;
  bool? success;
  dynamic serverMessage;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ResultCode'] = resultCode;
    map['Message'] = message;
    map['Success'] = success;
    map['ServerMessage'] = serverMessage;
    map['Data'] = data;
    return map;
  }

}