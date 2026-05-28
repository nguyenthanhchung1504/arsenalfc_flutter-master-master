class Video {
  const Video({
    required this.id,
    required this.title,
    required this.youtubeId,
    required this.thumbnailUrl,
    required this.publishedAt,
    this.description = '',
    this.tags = const [],
  });

  final String id;
  final String title;
  final String youtubeId;
  final String thumbnailUrl;
  final String description;
  final List<String> tags;
  final DateTime publishedAt;

  @override
  bool operator ==(Object other) => other is Video && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
