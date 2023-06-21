import 'package:arsenalfc_flutter/ui/search/searchnews/search_news_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/news/data_news.dart';

class SearchNewsController extends GetxController{
  final SearchNewsProviders providers;

  SearchNewsController({required this.providers});

  RxList<Data> list = <Data>[].obs;
  RxInt pageIndex = 1.obs;

  Rx<Data> data = Data().obs;

  ScrollController scrollController = ScrollController();

  String search = "";


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pageIndex = pageIndex++;
        getNewsPaging(true);
      }
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    });
  }

  void getNewsPaging(bool isScroll)  {
    var body = {"PageIndex": "$pageIndex", "PageSize": "20", "SearchValue": search};
    if(search.isEmpty){
      list.clear();
      pageIndex = 1.obs;
      update();
      return;
    }

    if (!isScroll) {
      list.clear();
      pageIndex = 1.obs;
    }
    var index = 0;
    providers.getNews(body).then((result) {
      if (result.body?.resultCode == 1) {
        result.body?.data?.forEach((element) {
          list.add(element);
          index++;
        }
        );
        update();
      } else {}
    });
  }
}