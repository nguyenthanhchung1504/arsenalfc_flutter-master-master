
import 'package:arsenalfc_flutter/model/videos/video_response.dart';
import 'package:arsenalfc_flutter/ui/search/searchvideo/search_video_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../api/Api.dart';
import '../../../model/videos/data_videos.dart';

class SearchVideoController extends GetxController{
  final SearchVideoProviders providers;

  SearchVideoController({required this.providers});

  RxList<DataVideo> list = <DataVideo>[].obs;
  RxInt pageIndex = 1.obs;

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
          getVideoPaging(true);
        }
      }
    });
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  void getVideoPaging(bool isScroll) async {
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
    VideoResponse? videoResponse = await providers.getVideos(pageIndex.value,search);

    if (videoResponse?.resultCode == 1) {
      videoResponse?.data?.forEach((element) {
        list.add(element);

      });
      update();
    } else {}
    if((videoResponse?.data?.length ?? 0) >= Api.PAGE_SIZE){
      pageIndex++;
    }else{
      isLoadMore.value = false;
    }
  }
}