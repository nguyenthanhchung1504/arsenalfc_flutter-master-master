import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../model/detailnews/DataNewDetail.dart';
import '../../../../model/news/data_news.dart';
import '../../model/detailnews/DetailNewModel.dart';
import '../../model/recomment/news/recommend_news.dart';
import '../../model/recomment/news/recomment_news_response.dart';
import 'detail_new_provider.dart';

class DetailController extends GetxController {
  final DetailProvider provider;

  DetailController({required this.provider});

  RxList<Data> listArgument = RxList();
  RxList<DataNewDetail>? listDetail = RxList();
  RxList<RecommendNews>? list = RxList();

   Rx<WebViewController> webViewController = WebViewController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    var argument = Get.arguments as List<dynamic>;
    if (argument.isNotEmpty) {
      argument.forEach((element) {
        if (element is Data) {
          listArgument.value.add(element);
        }
      });
    }
    webViewController.value.setJavaScriptMode(JavaScriptMode.unrestricted);

    getDetailNew((listArgument.value.firstOrNull?.id ?? 0).toString());
    getRecommendNews((listArgument.value.firstOrNull?.id ?? 0).toString());
  }

  void getDetailNew(String id) async {
    listDetail?.value.clear();
    DetailNewModel? response = await provider.getDetailNews(id);
    if (response?.resultCode == 1) {
      if (response?.data?.isNotEmpty == true) {
        response?.data?.forEach((data) {
          listDetail?.value.add(data);
        });
        var html = """<!DOCTYPE html>
    <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"><style>img{max-width: 100%; width:auto; height: auto;}</style></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          ${listDetail?.value.firstOrNull?.content ?? ""}
        </div>
      </body>
    </html>""";
        webViewController.value.loadHtmlString(html);
        update();
      }
    }
  }

  void getRecommendNews(String id) async {
    RecommendNewsResponse? response = await provider.getNewsRecommend(id);
    if (response?.resultCode == 1) {
      list?.value = response?.data?.recommendNews ?? [];
      update();
    }
  }
}
