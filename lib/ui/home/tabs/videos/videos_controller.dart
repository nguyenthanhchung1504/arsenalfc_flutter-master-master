import 'package:arsenalfc_flutter/model/videos/data_videos.dart';
import 'package:arsenalfc_flutter/model/videos/video_response.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../api/Api.dart';

class VideoController extends GetxController {
  final VideosProvider videosProvider;

  VideoController({required this.videosProvider});

  RxList<DataVideo> list = <DataVideo>[].obs;
  RxList<DataVideo> listHeader = <DataVideo>[].obs;
  RxInt pageIndex = 1.obs;

  ScrollController scrollController = ScrollController();
  RxBool isLoadMore = true.obs;
  RxBool isLoadDing = true.obs;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        if(isLoadMore.value) {
          isLoadDing.value = true;
          update();
          getVideosPaging(false);
        }
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getVideosPaging(true);
    getVideoHeader();
  }

  void getVideoHeader() async {
    VideoResponse? response = await videosProvider.getVideosHeader(1);
    if (response?.resultCode == 1) {
      response?.data?.forEach((element) {
        listHeader.add(element);
        update();
      });
    }
  }

  void getVideosPaging(bool isRefresh) async {
    if (isRefresh) {
      list.clear();
      pageIndex = 1.obs;
    }

    VideoResponse? response = await videosProvider.getVideos(pageIndex.value);
    isLoadDing.value = false;
    if (response?.resultCode == 1) {
      response?.data?.forEach((element) {
        list.add(element);
      });
    }
    update();
    if((response?.data?.length ?? 0) >= Api.PAGE_SIZE){
      pageIndex++;
    }else{
      isLoadMore.value = false;
    }
  }
}
