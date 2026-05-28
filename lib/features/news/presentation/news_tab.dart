import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/news.dart';
import '../../../extension/extension.dart';
import '../../../routes/routes_const.dart';
import '../../../utils/messages.dart';
import '../providers/news_list_notifier.dart';
import 'news_detail_page.dart';

/// Tab Tin tức — Riverpod (Phase 3).
class NewsTab extends ConsumerStatefulWidget {
  const NewsTab({super.key});

  @override
  ConsumerState<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends ConsumerState<NewsTab> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(newsListProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(newsListProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(newsListProvider.notifier).refresh(),
          child: _buildBody(context, state),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, NewsListState state) {
    if (state.isLoading && state.items.isEmpty && state.featured == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null &&
        state.items.isEmpty &&
        state.featured == null) {
      return _ErrorView(
        message: state.errorMessage!,
        onRetry: () => ref.read(newsListProvider.notifier).refresh(),
      );
    }

    return SingleChildScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(onSearch: () => Get.toNamed(AppConst.SEARCH_NEW)),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: Text(
              KeyString.KEY_LATEST.tr,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'montserrat_black',
                fontSize: 14,
                color: HexColor.fromHex('#0A1220'),
              ),
            ),
          ),
          if (state.featured != null) _FeaturedCard(news: state.featured!),
          _NewsGrid(items: state.items),
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
              KeyString.KEY_NEWS.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                fontFamily: 'montserrat_black',
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

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetail(context, news),
      child: Container(
        margin: const EdgeInsets.all(16),
        height: 271,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _NewsImage(url: news.thumbnailUrl),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.black54, Colors.transparent],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'montserrat_black',
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${DateFormat('dd/MM/yyyy').format(news.publishedAt)} · ${news.viewCount} lượt xem',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NewsGrid extends StatelessWidget {
  const _NewsGrid({required this.items});

  final List<News> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final news = items[index];
        final isEven = index.isEven;
        return GestureDetector(
          onTap: () => _openDetail(context, news),
          child: Container(
            margin: EdgeInsets.only(
              left: isEven ? 16 : 8,
              right: isEven ? 8 : 16,
              bottom: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: _NewsImage(url: news.thumbnailUrl),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  news.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'montserrat_black',
                    color: HexColor.fromHex('0A1220'),
                  ),
                ),
                Text(
                  '${DateFormat('dd/MM/yyyy').format(news.publishedAt)} · ${news.viewCount} lượt xem',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NewsImage extends StatelessWidget {
  const _NewsImage({required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.image_not_supported),
      );
    }
    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: double.infinity,
      placeholder: (_, __) => Image.asset(
        'assets/images/loading.gif',
        fit: BoxFit.cover,
      ),
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

void _openDetail(BuildContext context, News news) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => NewsDetailPage(newsId: news.id),
    ),
  );
}
