import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/entities/news.dart';
import '../../../domain/repositories/news_repository.dart';

/// Trạng thái danh sách tin — featured + grid + pagination.
class NewsListState {
  const NewsListState({
    this.featured,
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.nextCursor,
  });

  final News? featured;
  final List<News> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final Object? nextCursor;

  factory NewsListState.initial() => const NewsListState(isLoading: true);

  NewsListState copyWith({
    News? featured,
    List<News>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorMessage,
    Object? nextCursor,
    bool clearError = false,
  }) {
    return NewsListState(
      featured: featured ?? this.featured,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }
}

class NewsListNotifier extends StateNotifier<NewsListState> {
  NewsListNotifier(this._repo) : super(NewsListState.initial()) {
    refresh();
  }

  final NewsRepository _repo;
  static const _firstPageSize = 21;
  static const _pageSize = 20;

  Future<void> refresh() async {
    state = NewsListState.initial();
    final result = await _repo.getNews(pageSize: _firstPageSize);
    result.fold(
      (page) {
        final all = page.items;
        if (all.isEmpty) {
          state = const NewsListState(
            isLoading: false,
            hasMore: false,
            items: [],
          );
          return;
        }
        state = NewsListState(
          featured: all.first,
          items: all.length > 1 ? all.sublist(1) : [],
          isLoading: false,
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        );
      },
      (failure) {
        state = NewsListState(
          isLoading: false,
          hasMore: false,
          errorMessage: failure.message,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    state = state.copyWith(isLoadingMore: true, clearError: true);

    final result = await _repo.getNews(
      pageSize: _pageSize,
      cursor: state.nextCursor,
    );

    result.fold(
      (page) {
        state = state.copyWith(
          items: [...state.items, ...page.items],
          isLoadingMore: false,
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        );
      },
      (failure) {
        state = state.copyWith(
          isLoadingMore: false,
          errorMessage: failure.message,
        );
      },
    );
  }
}

final newsListProvider =
    StateNotifierProvider<NewsListNotifier, NewsListState>((ref) {
  return NewsListNotifier(ref.watch(newsRepositoryProvider));
});
