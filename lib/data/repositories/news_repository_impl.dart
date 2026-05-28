import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../domain/entities/news.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/repositories/news_repository.dart';

/// Stub — Phase 3 sẽ thay bằng `FirestoreNewsRepository`.
class StubNewsRepository implements NewsRepository {
  const StubNewsRepository();

  @override
  Future<Result<Paginated<News>>> getNews({
    int pageSize = 20,
    Object? cursor,
  }) async =>
      const Err(NotImplementedFailure('News chưa kết nối Firestore.'));

  @override
  Future<Result<News>> getNewsById(String id) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<List<News>>> getRelated(String newsId, {int limit = 5}) async =>
      const Err(NotImplementedFailure());

  @override
  Future<Result<List<News>>> search(String query, {int limit = 20}) async =>
      const Err(NotImplementedFailure());
}
