import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/firestore_video_repository.dart';
import '../../../domain/entities/video.dart';

class SearchVideoController extends GetxController {
  SearchVideoController();

  final _repo = FirestoreVideoRepository(FirebaseFirestore.instance);

  RxList<Video> list = <Video>[].obs;
  RxBool isLoading = false.obs;

  final scrollController = ScrollController();
  String search = '';

  @override
  void onInit() {
    super.onInit();
    FocusScope.of(Get.context!).requestFocus(FocusNode());
  }

  Future<void> searchVideos() async {
    final query = search.trim();
    if (query.isEmpty) {
      list.clear();
      return;
    }

    isLoading.value = true;
    final result = await _repo.search(query);
    isLoading.value = false;

    result.fold(
      (videos) => list.assignAll(videos),
      (_) => list.clear(),
    );
  }
}
