import 'package:arsenalfc_flutter/api/Api.dart';
import 'package:arsenalfc_flutter/model/news/news_response.dart';
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
  RxBool isLoadMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if(isLoadMore.value) {
          getNewsPaging(true);
        }
      }
      FocusScope.of(Get.context!).requestFocus(FocusNode());
    });
  }

  void getNewsPaging(bool isScroll) async{
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
    NewsResponse? newsResponse = await providers.getNews(pageIndex.value,search);

    if (newsResponse?.resultCode == 1) {
      newsResponse?.data?.forEach((element) {
        list.add(element);
      }
      );
      update();
    } else {}

    if((newsResponse?.data?.length ?? 0) >= Api.PAGE_SIZE){
      pageIndex++;
    }else{
      isLoadMore.value = false;
    }
  }
}