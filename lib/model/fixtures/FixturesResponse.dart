import 'Parameters.dart';
import 'Paging.dart';
import 'FixturesData.dart';

class FixturesResponse {
  FixturesResponse({
      this.get, 
      this.parameters, 
      this.errors,
      this.results, 
      this.paging, 
      this.response,});

  FixturesResponse.fromJson(dynamic json) {
    get = json['get'];
    parameters = json['parameters'] != null ? Parameters.fromJson(json['parameters']) : null;
    if (json['errors'] != null) {
      errors = [];
    }
    results = json['results'];
    paging = json['paging'] != null ? Paging.fromJson(json['paging']) : null;
    if (json['response'] != null) {
      response = [];
      json['response'].forEach((v) {
        response?.add(FixturesData.fromJson(v));
      });
    }
  }
  String? get;
  Parameters? parameters;
  List<dynamic>? errors = [];
  int? results;
  Paging? paging;
  List<FixturesData>? response;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['get'] = get;
    if (parameters != null) {
      map['parameters'] = parameters?.toJson();
    }
    // if (errors != null) {
    //   map['errors'] = errors.map((v) => v.toJson()).toList();
    // }
    map['results'] = results;
    if (paging != null) {
      map['paging'] = paging?.toJson();
    }
    if (response != null) {
      map['response'] = response?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}