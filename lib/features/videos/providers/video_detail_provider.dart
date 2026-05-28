import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/entities/video.dart';

final videoDetailProvider = FutureProvider.family<Video?, String>((ref, id) async {
  final result = await ref.watch(videoRepositoryProvider).getVideoById(id);
  return result.fold((video) => video, (_) => null);
});

final videoRelatedProvider =
    FutureProvider.family<List<Video>, String>((ref, id) async {
  final result =
      await ref.watch(videoRepositoryProvider).getRelated(id, limit: 6);
  return result.fold((list) => list, (_) => []);
});
