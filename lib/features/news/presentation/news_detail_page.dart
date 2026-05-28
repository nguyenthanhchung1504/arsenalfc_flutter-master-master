import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../domain/entities/news.dart';
import '../../../utils/messages.dart';
import '../providers/news_detail_provider.dart';

class NewsDetailPage extends ConsumerWidget {
  const NewsDetailPage({super.key, required this.newsId});

  final String newsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(newsDetailProvider(newsId));
    final relatedAsync = ref.watch(newsRelatedProvider(newsId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyString.KEY_DETAIL_NEW.tr,
          style: const TextStyle(
            fontFamily: 'montserrat_black',
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Không tải được bài viết.')),
        data: (news) {
          if (news == null) {
            return const Center(child: Text('Không tìm thấy bài viết.'));
          }
          return Column(
            children: [
              Expanded(child: _ArticleWebView(news: news)),
              relatedAsync.when(
                loading: () => const SizedBox(
                  height: 80,
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (_, __) => const SizedBox.shrink(),
                data: (related) => _RelatedStrip(
                  items: related,
                  onTap: (id) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute<void>(
                        builder: (_) => NewsDetailPage(newsId: id),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ArticleWebView extends StatefulWidget {
  const _ArticleWebView({required this.news});

  final News news;

  @override
  State<_ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<_ArticleWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(_buildHtml(widget.news));
  }

  String _buildHtml(News news) {
    return '''
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  body { margin: 0; padding: 16px; font-family: sans-serif; }
  img { max-width: 100%; height: auto; }
  h1 { font-size: 20px; }
</style>
</head>
<body>
  <h1>${_escape(news.title)}</h1>
  <p style="color:#666;font-size:12px;">
    ${DateFormat('dd/MM/yyyy').format(news.publishedAt)} · ${news.viewCount} lượt xem
  </p>
  ${news.contentHtml.isNotEmpty ? news.contentHtml : '<p>${_escape(news.excerpt)}</p>'}
</body>
</html>''';
  }

  String _escape(String text) {
    return text
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;');
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

class _RelatedStrip extends StatelessWidget {
  const _RelatedStrip({required this.items, required this.onTap});

  final List<News> items;
  final void Function(String id) onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              KeyString.KEY_SUGGEST.tr,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontFamily: 'montserrat_black',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return GestureDetector(
                  onTap: () => onTap(item.id),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CachedNetworkImage(
                              imageUrl: item.thumbnailUrl,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
