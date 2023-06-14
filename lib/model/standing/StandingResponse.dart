import 'Response.dart';

class StandingResponse {
  StandingResponse({
      this.response,});

  StandingResponse.fromJson(dynamic json) {
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(Response.fromJson(v));
      });
    }
  }
  List<Response>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}