import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:pod_player/pod_player.dart';

import '../../../domain/entities/video.dart';
import '../../../extension/extension.dart';
import '../../../utils/colors.dart';
import '../../../utils/messages.dart';
import '../../../utils/utils.dart';
import '../providers/video_detail_provider.dart';

class VideoDetailPage extends ConsumerStatefulWidget {
  const VideoDetailPage({super.key, required this.videoId});

  final String videoId;

  @override
  ConsumerState<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends ConsumerState<VideoDetailPage> {
  PodPlayerController? _player;
  String? _loadedVideoId;

  @override
  void dispose() {
    _player?.dispose();
    super.dispose();
  }

  void _initPlayer(Video video) {
    if (_loadedVideoId == video.id) return;
    _player?.dispose();
    _loadedVideoId = video.id;

    if (video.youtubeId.isEmpty) {
      _player = null;
      return;
    }

    _player = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
        'https://www.youtube.com/watch?v=${video.youtubeId}',
      ),
    )..initialise();
  }

  @override
  Widget build(BuildContext context) {
    final detailAsync = ref.watch(videoDetailProvider(widget.videoId));
    final relatedAsync = ref.watch(videoRelatedProvider(widget.videoId));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          KeyString.KEY_DETAIL_VIDEO.tr,
          style: const TextStyle(
            fontFamily: 'montserrat_black',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.black),
          onPressed: () {
            _player?.pause();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Không tải được video.')),
        data: (video) {
          if (video == null) {
            return const Center(child: Text('Không tìm thấy video.'));
          }
          _initPlayer(video);

          return Column(
            children: [
              if (_player != null)
                PodVideoPlayer(controller: _player!)
              else
                const AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ColoredBox(
                    color: Colors.black12,
                    child: Center(child: Icon(Icons.videocam_off)),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: 'montserrat_black',
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(video.publishedAt),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Container(height: 1, color: const Color(AppColors.GRAY_LIGHT)),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    KeyString.KEY_SUGGEST.tr,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'montserrat_black',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: relatedAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (related) => _RelatedList(
                    items: related,
                    onTap: (id) {
                      _player?.pause();
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute<void>(
                          builder: (_) => VideoDetailPage(videoId: id),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: SizedBox(
        width: AdSize.banner.width.toDouble(),
        height: AdSize.banner.height.toDouble(),
        child: AdWidget(
          ad: BannerAd(
            adUnitId: StringUtils.getBannerAdUnitId(),
            request: const AdRequest(),
            size: AdSize.banner,
            listener: BannerAdListener(
              onAdFailedToLoad: (ad, _) => ad.dispose(),
            ),
          )..load(),
        ),
      ),
    );
  }
}

class _RelatedList extends StatelessWidget {
  const _RelatedList({required this.items, required this.onTap});

  final List<Video> items;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('Chưa có video gợi ý.'));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final video = items[index];
        return GestureDetector(
          onTap: () => onTap(video.id),
          child: Container(
            margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 2 - 45,
                  height: 108,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _VideoThumb(url: video.thumbnailUrl),
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
                            fontSize: 16,
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

class _VideoThumb extends StatelessWidget {
  const _VideoThumb({required this.url});

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
