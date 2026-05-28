import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/firestore_parse.dart';
import '../../../domain/entities/video.dart';
import '../news/news_dto.dart' show TimestampConverter;

part 'video_dto.freezed.dart';
part 'video_dto.g.dart';

@freezed
class VideoDto with _$VideoDto {
  const VideoDto._();

  const factory VideoDto({
    required String id,
    required String title,
    @Default('') String youtubeId,
    @Default('') String thumbnailUrl,
    @Default('') String description,
    @Default(<String>[]) List<String> tags,
    @TimestampConverter() DateTime? publishedAt,
  }) = _VideoDto;

  factory VideoDto.fromJson(Map<String, dynamic> json) =>
      _$VideoDtoFromJson(json);

  factory VideoDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return VideoDto(
      id: doc.id,
      title: data['title'] as String? ?? '',
      youtubeId: data['youtube_id'] as String? ?? '',
      thumbnailUrl: data['thumbnail_url'] as String? ?? '',
      description: data['description'] as String? ?? '',
      tags: (data['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      publishedAt: parseFirestoreDate(data['published_at']),
    );
  }

  Video toEntity() => Video(
        id: id,
        title: title,
        youtubeId: youtubeId,
        thumbnailUrl: thumbnailUrl,
        description: description,
        tags: tags,
        publishedAt: publishedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
      );
}
