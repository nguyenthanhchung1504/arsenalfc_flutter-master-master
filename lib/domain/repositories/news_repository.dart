import '../../core/error/result.dart';
import '../entities/news.dart';
import '../entities/paginated.dart';

abstract interface class NewsRepository {
  /// Trang đầu (cursor = null) hoặc trang kế tiếp theo `cursor`.
  Future<Result<Paginated<News>>> getNews({
    int pageSize = 20,
    Object? cursor,
  });

  Future<Result<News>> getNewsById(String id);

  /// Bài liên quan theo tag (Phase 3 — Firestore client-side filter).
  Future<Result<List<News>>> getRelated(String newsId, {int limit = 5});

  /// Tìm kiếm theo từ khoá — v1 dùng client filter, v1.1 chuyển Algolia.
  Future<Result<List<News>>> search(String query, {int limit = 20});
}
