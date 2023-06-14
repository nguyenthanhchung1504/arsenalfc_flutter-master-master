import 'package:arsenalfc_flutter/model/news/data_news.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class NewsController extends GetxController {
  final NewsProvider newsProvider;

  NewsController({required this.newsProvider});

  RxList<Data> list = <Data>[].obs;
  RxInt pageIndex = 1.obs;

  Rx<Data> data = Data().obs;

  ScrollController scrollController = ScrollController();


  @override
  void onInit() {
    getNewsPaging(true);
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pageIndex = pageIndex++;
        getNewsPaging(false);
      }
    });
  }

  void getNewsPaging(bool isRefresh) async {
    var body = {"PageIndex": "$pageIndex", "PageSize": "21", "SearchValue": ""};
    if (isRefresh) {
      list.clear();
      pageIndex = 1.obs;
    }
    var index = 0;
    await newsProvider.getNews(body).then((result) {
      if (result.body?.resultCode == 1) {
        result.body?.data?.forEach((element) {
          if (index != 0) {
            list.add(element);
          } else {
            if (pageIndex != 1.obs) {
              list.add(element);
            } else {
              data.value = element;
            }
          }
          index++;


        }
        );
        update();
      } else {}
    });
  }
}
