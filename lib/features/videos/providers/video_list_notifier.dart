import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/providers.dart';
import '../../../domain/entities/video.dart';
import '../../../domain/repositories/video_repository.dart';

class VideoListState {
  const VideoListState({
    this.carousel = const [],
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.errorMessage,
    this.nextCursor,
  });

  final List<Video> carousel;
  final List<Video> items;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final String? errorMessage;
  final Object? nextCursor;

  factory VideoListState.initial() => const VideoListState(isLoading: true);

  VideoListState copyWith({
    List<Video>? carousel,
    List<Video>? items,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    String? errorMessage,
    Object? nextCursor,
    bool clearError = false,
  }) {
    return VideoListState(
      carousel: carousel ?? this.carousel,
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      nextCursor: nextCursor ?? this.nextCursor,
    );
  }
}

class VideoListNotifier extends StateNotifier<VideoListState> {
  VideoListNotifier(this._repo) : super(VideoListState.initial()) {
    refresh();
  }

  final VideoRepository _repo;
  static const _carouselSize = 3;
  static const _firstPageSize = 21;
  static const _pageSize = 20;

  Future<void> refresh() async {
    state = VideoListState.initial();
    final result = await _repo.getVideos(pageSize: _firstPageSize);
    result.fold(
      (page) {
        final all = page.items;
        if (all.isEmpty) {
          state = const VideoListState(isLoading: false, hasMore: false);
          return;
        }
        final carouselEnd = all.length < _carouselSize ? all.length : _carouselSize;
        state = VideoListState(
          carousel: all.sublist(0, carouselEnd),
          items: all.length > carouselEnd ? all.sublist(carouselEnd) : [],
          isLoading: false,
          hasMore: page.hasMore,
          nextCursor: page.nextCursor,
        );
      },
      (failure) {
        state = VideoListState(
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

    final result = await _repo.getVideos(
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

final videoListProvider =
    StateNotifierProvider<VideoListNotifier, VideoListState>((ref) {
  return VideoListNotifier(ref.watch(videoRepositoryProvider));
});
