class News {
  const News({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.excerpt,
    required this.contentHtml,
    required this.publishedAt,
    this.slug = '',
    this.tags = const [],
    this.authorId,
    this.viewCount = 0,
  });

  final String id;
  final String title;
  final String slug;
  final String thumbnailUrl;
  final String excerpt;
  final String contentHtml;
  final List<String> tags;
  final DateTime publishedAt;
  final String? authorId;
  final int viewCount;

  News copyWith({
    String? id,
    String? title,
    String? slug,
    String? thumbnailUrl,
    String? excerpt,
    String? contentHtml,
    List<String>? tags,
    DateTime? publishedAt,
    String? authorId,
    int? viewCount,
  }) {
    return News(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
      excerpt: excerpt ?? this.excerpt,
      contentHtml: contentHtml ?? this.contentHtml,
      tags: tags ?? this.tags,
      publishedAt: publishedAt ?? this.publishedAt,
      authorId: authorId ?? this.authorId,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  @override
  bool operator ==(Object other) => other is News && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
