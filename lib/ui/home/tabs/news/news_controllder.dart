import 'package:arsenalfc_flutter/api/Api.dart';
import 'package:arsenalfc_flutter/model/news/data_news.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/news/news_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../model/news/news_response.dart';

class NewsController extends GetxController {
  final NewsProvider newsProvider;

  NewsController({required this.newsProvider});

  RxList<Data> list = <Data>[].obs;
  RxInt pageIndex = 1.obs;

  Rx<Data> data = Data().obs;

  ScrollController scrollController = ScrollController();
  RxBool isLoadMore = true.obs;
  RxBool isLoadDing = true.obs;


  @override
  void onInit() {
    getNewsPaging(true);
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if(isLoadMore.value) {
          isLoadDing.value = true;
          update();
          getNewsPaging(false);
        }
      }
    });
  }

  void getNewsPaging(bool isRefresh) async {
    if (isRefresh) {
      list.clear();
      pageIndex = 1.obs;
    }
    var index = 0;
    NewsResponse? newsResponse = await newsProvider.getNews(pageIndex.value);
    isLoadDing.value = false;
    if (newsResponse?.resultCode == 1) {
      newsResponse?.data?.forEach((element) {
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
      });
    }
    update();
    if(pageIndex.value == 1){
      if((newsResponse?.data?.length ?? 0) >= 21){
        pageIndex++;
      }else{
        isLoadMore.value = false;
      }
    }else{
      if((newsResponse?.data?.length ?? 0) >= Api.PAGE_SIZE){
        pageIndex++;
      }else{
        isLoadMore.value = false;
      }
    }

  }
}


