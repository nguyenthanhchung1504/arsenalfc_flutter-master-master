import 'package:arsenalfc_flutter/model/videos/data_videos.dart';
import 'package:arsenalfc_flutter/ui/home/tabs/videos/videos_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  final VideosProvider videosProvider;

  VideoController({required this.videosProvider});

  RxList<DataVideo> list = <DataVideo>[].obs;
  RxList<DataVideo> listHeader = <DataVideo>[].obs;
  RxInt pageIndex = 1.obs;

  ScrollController scrollController = ScrollController();



  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pageIndex = pageIndex++;
        getVideosPaging(false);
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
    var body = {"PageIndex": "1", "PageSize": "5", "SearchValue": ""};

    await videosProvider.getVideos(body).then((result) {
      if (result.body?.resultCode == 1) {
        result.body?.data?.forEach((element) {
          listHeader.add(element);
        });
        update();
      } else {}
    });
  }

  void getVideosPaging(bool isRefresh) async {
    var body = {"PageIndex": "$pageIndex", "PageSize": "20", "SearchValue": ""};
    if (isRefresh) {
      list.clear();
      pageIndex = 1.obs;
    }

    await videosProvider.getVideos(body).then((result) {
      if (result.body?.resultCode == 1) {
        result.body?.data?.forEach((element) {
          list.add(element);
        });
        update();
      } else {}
    });
  }
}
