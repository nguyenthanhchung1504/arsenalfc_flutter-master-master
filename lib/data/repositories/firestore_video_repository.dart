import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firestore_paths.dart';
import '../../core/error/failure.dart';
import '../../core/error/result.dart';
import '../../domain/entities/paginated.dart';
import '../../domain/entities/video.dart';
import '../../domain/repositories/video_repository.dart';
import '../models/video/video_dto.dart';

class FirestoreVideoRepository implements VideoRepository {
  FirestoreVideoRepository(this._db);

  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _col =>
      _db.collection(FirestorePaths.videos);

  @override
  Future<Result<Paginated<Video>>> getVideos({
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
          snap.docs.map((d) => VideoDto.fromFirestore(d).toEntity()).toList();

      return Paginated(
        items: items,
        nextCursor: snap.docs.isEmpty ? null : snap.docs.last,
      );
    }, onError: _mapError);
  }

  @override
  Future<Result<Video>> getVideoById(String id) async {
    return guard(() async {
      final doc = await _col.doc(id).get();
      if (!doc.exists) {
        throw const ValidationFailure('Không tìm thấy video.');
      }
      return VideoDto.fromFirestore(doc).toEntity();
    }, onError: _mapError);
  }

  @override
  Future<Result<List<Video>>> getRelated(String videoId, {int limit = 5}) async {
    return guard(() async {
      final snap = await _col
          .orderBy('published_at', descending: true)
          .limit(limit + 1)
          .get();
      return snap.docs
          .map((d) => VideoDto.fromFirestore(d).toEntity())
          .where((v) => v.id != videoId)
          .take(limit)
          .toList();
    }, onError: _mapError);
  }

  @override
  Future<Result<List<Video>>> search(String query, {int limit = 20}) async {
    return guard(() async {
      final q = query.trim().toLowerCase();
      if (q.isEmpty) return <Video>[];

      final snap = await _col
          .orderBy('published_at', descending: true)
          .limit(40)
          .get();

      return snap.docs
          .map((d) => VideoDto.fromFirestore(d).toEntity())
          .where((v) => v.title.toLowerCase().contains(q))
          .take(limit)
          .toList();
    }, onError: _mapError);
  }

  Failure _mapError(Object error, StackTrace stack) {
    if (error is Failure) return error;
    return DatabaseFailure(cause: error, stackTrace: stack);
  }
}
