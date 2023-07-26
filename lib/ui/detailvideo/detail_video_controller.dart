import 'dart:convert';

import 'package:arsenalfc_flutter/model/detailvideo/detail_video_response.dart';
import 'package:arsenalfc_flutter/model/detailvideo/video_info.dart';
import 'package:arsenalfc_flutter/model/videos/data_videos.dart';
import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';

import '../../../../model/detailvideo/data_detail_video_model.dart';
import '../../model/recomment/video/recommend_video_response.dart';
import '../../model/videos/video_response.dart';
import 'detail_video_provider.dart';

class DetailVideoController extends GetxController {
  final DetailVideoProvider provider;

  DetailVideoController({required this.provider});

  RxList<DataVideo> listArgument = RxList();

  Rx<DataDetailVideoModel> entity = DataDetailVideoModel().obs;
  Rx<VideoInfo> videoInfo = VideoInfo().obs;
  RxList<DataVideo> list = <DataVideo>[].obs;

  late final PodPlayerController podController;

  @override
  void onInit() {
    super.onInit();
    var argument = Get.arguments as List<dynamic>;
    if (argument.isNotEmpty) {
      argument.forEach((element) {
        if (element is DataVideo) {
          listArgument.add(element);
        }
      });
    }

    if (listArgument.value.firstOrNull?.videoInfo.isNullOrBlank == true ||
        listArgument.value.firstOrNull?.youtubeLink?.isNotEmpty == true) {
      podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
            listArgument.value.firstOrNull?.youtubeLink ?? ""),
      )..initialise();
      return;
    }
    var valueMap = json.decode(listArgument.value.firstOrNull?.videoInfo ?? "");
    VideoInfo info = VideoInfo.fromJson(valueMap);

    videoInfo.value = info;

    if (videoInfo.value.uri?.isNotEmpty == true) {
      podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.vimeo(
            (videoInfo.value.uri ?? "").split("/").lastOrNull ?? ""),
      )..initialise();
    }
  }

  @override
  void onReady() {
    super.onReady();
    getDetailVideo((listArgument.firstOrNull?.id ?? 0).toString());
    getVideosPaging();
  }

  void getDetailVideo(String id) async {
    DetailVideoResponse? response = await provider.getDetailVideo(id);
    response?.data?.forEach((video) {
      entity.value = video;

      if (video.youtubeLink?.isNotEmpty == true) {
        podController.changeVideo(
            playVideoFrom: PlayVideoFrom.youtube(video.youtubeLink ?? ""));
      } else {
        if (video.videoInfo?.isNotEmpty == true) {
          var valueMap = json.decode(video.videoInfo ?? "");
          VideoInfo info = VideoInfo.fromJson(valueMap);
          videoInfo.value = info;
          if (videoInfo.value.uri?.isNotEmpty == true) {
            podController.changeVideo(
                playVideoFrom: PlayVideoFrom.vimeo(
                    (videoInfo.value.uri ?? "").split("/").lastOrNull ?? ""));
          }
        }
      }
    });
    update();
  }

  void getVideosPaging() async {
    list.clear();
    RecommendVideoResponse? response = await provider.getVideos((listArgument.firstOrNull?.id ?? 0).toString());
    response?.data?.recommendVideo?.forEach((element) {
      if (listArgument.firstOrNull?.id != element.id) {
        list.add(element);
      }
    });
    update();
  }

  @override
  void dispose() {
    podController.pause();
    podController.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    podController.pause();
    podController.dispose();
    super.onClose();
  }
}
