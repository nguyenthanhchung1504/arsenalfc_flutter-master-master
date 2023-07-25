import 'recommend_news.dart';

class DataRecommendNews {
  DataRecommendNews({
      this.currentNews, 
      this.recommendNews,});

  DataRecommendNews.fromJson(dynamic json) {
    currentNews = json['CurrentNews'];
    if (json['RecommendNews'] != null) {
      recommendNews = [];
      json['RecommendNews'].forEach((v) {
        recommendNews?.add(RecommendNews.fromJson(v));
      });
    }
  }
  dynamic currentNews;
  List<RecommendNews>? recommendNews;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['CurrentNews'] = currentNews;
    if (recommendNews != null) {
      map['RecommendNews'] = recommendNews?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}