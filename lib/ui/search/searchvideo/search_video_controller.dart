
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/news/data_news.dart';

class SearchVideoController extends GetxController{
  final SearchVideoProviders providers;

  SearchVideoController({required this.providers});

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
        getVideoPaging(true);
      }
    });
  }

  void getVideoPaging(bool isScroll) async {
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
    await providers.getVideos(body).then((result) {
      if (result.body?.resultCode == 1) {
        result.body?.data?.forEach((element) {
          list.add(element);
        });
        update();
      } else {}
    });
  }
}