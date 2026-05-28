import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/utils/firestore_parse.dart';
import '../../../domain/entities/news.dart';

part 'news_dto.freezed.dart';
part 'news_dto.g.dart';

@freezed
class NewsDto with _$NewsDto {
  const NewsDto._();

  const factory NewsDto({
    required String id,
    required String title,
    @Default('') String slug,
    @Default('') String thumbnailUrl,
    @Default('') String excerpt,
    @Default('') String contentHtml,
    @Default(<String>[]) List<String> tags,
    @TimestampConverter() DateTime? publishedAt,
    String? authorId,
    @Default(0) int viewCount,
  }) = _NewsDto;

  factory NewsDto.fromJson(Map<String, dynamic> json) =>
      _$NewsDtoFromJson(json);

  factory NewsDto.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return NewsDto(
      id: doc.id,
      title: data['title'] as String? ?? '',
      slug: data['slug'] as String? ?? '',
      thumbnailUrl: data['thumbnail_url'] as String? ?? '',
      excerpt: data['excerpt'] as String? ?? '',
      contentHtml: data['content_html'] as String? ?? '',
      tags: (data['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      publishedAt: parseFirestoreDate(data['published_at']),
      authorId: data['author_id'] as String?,
      viewCount: (data['view_count'] as num?)?.toInt() ?? 0,
    );
  }

  News toEntity() => News(
        id: id,
        title: title,
        slug: slug,
        thumbnailUrl: thumbnailUrl,
        excerpt: excerpt,
        contentHtml: contentHtml,
        tags: tags,
        publishedAt: publishedAt ?? DateTime.fromMillisecondsSinceEpoch(0),
        authorId: authorId,
        viewCount: viewCount,
      );
}

class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    return parseFirestoreDate(json);
  }

  @override
  Object? toJson(DateTime? object) => object?.millisecondsSinceEpoch;
}
