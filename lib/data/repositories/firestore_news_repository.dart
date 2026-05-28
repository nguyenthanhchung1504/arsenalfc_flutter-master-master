import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../domain/entities/news.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news/news_dto.dart';

class FirestoreNewsRepository implements NewsRepository {
  FirestoreNewsRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.news);

  @override
  Future<Result<Paginated<News>>> getNews({
    int pageSize = 20,
    Object? cursor,
  }) async {
    return guard(() async {
      Query<Map<String, dynamic>> query = _col
          .orderBy('published_at', descending: true)
          .limit(pageSize);

      if (cursor is DocumentSnapshot<Map<String, dynamic>>) {
        query = query.startAfterDocument(cursor);
      }

      final snap = await query.get();
      final items =
          snap.docs.map((d) => NewsDto.fromFirestore(d).toEntity()).toList();

      return Paginated(
        items: items,
        nextCursor: snap.docs.isEmpty ? null : snap.docs.last,
      );
    }, onError: _mapFirestoreError);
  }

  @override
  Future<Result<News>> getNewsById(String id) async {
    return guard(() async {
      final doc = await _col.doc(id).get();
      if (!doc.exists) {
        throw const ValidationFailure('Không tìm thấy bài viết.');
      }
      return NewsDto.fromFirestore(doc).toEntity();
    }, onError: _mapFirestoreError);
  }

  @override
  Future<Result<List<News>>> getRelated(String newsId, {int limit = 5}) async {
    return guard(() async {
      final current = await getNewsById(newsId);
      if (current is Err<News>) return <News>[];

      final news = (current as Ok<News>).value;
      if (news.tags.isEmpty) {
        final snap = await _col
            .orderBy('published_at', descending: true)
            .limit(limit + 1)
            .get();
        return snap.docs
            .map((d) => NewsDto.fromFirestore(d).toEntity())
            .where((n) => n.id != newsId)
            .take(limit)
            .toList();
      }

      final tag = news.tags.first;
      final snap = await _col
          .where('tags', arrayContains: tag)
          .orderBy('published_at', descending: true)
          .limit(limit + 1)
          .get();

      return snap.docs
          .map((d) => NewsDto.fromFirestore(d).toEntity())
          .where((n) => n.id != newsId)
          .take(limit)
          .toList();
    }, onError: _mapFirestoreError);
  }

  @override
  Future<Result<List<News>>> search(String query, {int limit = 20}) async {
    return guard(() async {
      final q = query.trim().toLowerCase();
      if (q.isEmpty) return <News>[];

      final snap = await _col
          .orderBy('published_at', descending: true)
          .limit(50)
          .get();

      return snap.docs
          .map((d) => NewsDto.fromFirestore(d).toEntity())
          .where(
            (n) =>
                n.title.toLowerCase().contains(q) ||
                n.excerpt.toLowerCase().contains(q),
          )
          .take(limit)
          .toList();
    }, onError: _mapFirestoreError);
  }

  Failure _mapFirestoreError(Object error, StackTrace stack) {
    if (error is Failure) return error;
    return DatabaseFailure(cause: error, stackTrace: stack);
  }
}
