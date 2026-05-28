import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pageviewj/pageviewj.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/entities/video.dart';
import '../../../extension/extension.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/colors.dart';
import '../../../utils/messages.dart';
import '../providers/video_list_notifier.dart';
import 'video_detail_page.dart';

/// Tab Video — Riverpod + Firestore (Phase 3).
class VideosTab extends ConsumerStatefulWidget {
  const VideosTab({super.key});

  @override
  ConsumerState<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends ConsumerState<VideosTab> {
  final _scrollController = ScrollController();
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(videoListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(videoListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(videoListProvider.notifier).refresh(),
          child: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, VideoListState state) {
    if (state.isLoading && state.carousel.isEmpty && state.items.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null &&
        state.carousel.isEmpty &&
        state.items.isEmpty) {
      return _ErrorView(
        message: state.errorMessage!,
        onRetry: () => ref.read(videoListProvider.notifier).refresh(),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(onSearch: () => Get.toNamed(AppConst.SEARCH_VIDEO)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Text(
              KeyString.KEY_LATEST.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                fontFamily: 'montserrat_black',
                color: HexColor.fromHex('#0A1220'),
              ),
            ),
          ),
          if (state.carousel.isNotEmpty)
            _Carousel(
              videos: state.carousel,
              pageController: _pageController,
            ),
          _VideoList(items: state.items),
          if (state.isLoadingMore)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onSearch});

  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              KeyString.KEY_VIDEO.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'montserrat_black',
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(onPressed: onSearch, icon: const Icon(Icons.search)),
        ],
      ),
    );
  }
}

class _Carousel extends StatelessWidget {
  const _Carousel({
    required this.videos,
    required this.pageController,
  });

  final List<Video> videos;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          SizedBox(
            height: 365,
            child: PageViewJ(
              controller: pageController,
              itemCount: videos.length,
              transform: ShuttersCubeTransform(),
              itemBuilder: (context, index) {
                final video = videos[index];
                return GestureDetector(
                  onTap: () => _openDetail(context, video),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                        child: SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: _VideoImage(url: video.thumbnailUrl),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'montserrat_black',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        DateFormat('dd/MM/yyyy').format(video.publishedAt),
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          SmoothPageIndicator(
            controller: pageController,
            count: videos.length,
            effect: const ExpandingDotsEffect(
              spacing: 8,
              radius: 6,
              dotWidth: 6,
              dotHeight: 6,
              dotColor: Colors.grey,
              activeDotColor: Color(AppColors.RED_LIGHT),
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoList extends StatelessWidget {
  const _VideoList({required this.items});

  final List<Video> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final video = items[index];
        return GestureDetector(
          onTap: () => _openDetail(context, video),
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 45,
                  height: 108,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _VideoImage(url: video.thumbnailUrl),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'montserrat_black',
                            fontWeight: FontWeight.w700,
                            color: HexColor.fromHex('0A1220'),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          DateFormat('dd/MM/yyyy').format(video.publishedAt),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _VideoImage extends StatelessWidget {
  const _VideoImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const ColoredBox(
        color: Colors.black12,
        child: Icon(Icons.image_not_supported),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (_, __) =>
          Image.asset('assets/images/loading.gif', fit: BoxFit.cover),
      errorWidget: (_, __, ___) => const Icon(Icons.error),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.cloud_off, size: 48, color: Colors.grey),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: const Text('Thử lại')),
          ],
        ),
      ),
    );
  }
}

void _openDetail(BuildContext context, Video video) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => VideoDetailPage(videoId: video.id),
    ),
  );
}
