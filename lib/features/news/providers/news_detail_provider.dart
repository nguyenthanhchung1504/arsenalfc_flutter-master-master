import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/entities/news.dart';

final newsDetailProvider = FutureProvider.family<News?, String>((ref, id) async {
  final result = await ref.watch(newsRepositoryProvider).getNewsById(id);
  return result.fold((news) => news, (_) => null);
});

final newsRelatedProvider =
    FutureProvider.family<List<News>, String>((ref, id) async {
  final result =
      await ref.watch(newsRepositoryProvider).getRelated(id, limit: 6);
  return result.fold((list) => list, (_) => []);
});
