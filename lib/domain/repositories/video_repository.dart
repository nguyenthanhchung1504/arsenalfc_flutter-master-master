import '../../core/error/result.dart';
import '../entities/paginated.dart';
import '../entities/video.dart';

abstract interface class VideoRepository {
  Future<Result<Paginated<Video>>> getVideos({
    int pageSize = 20,
    Object? cursor,
  });

  Future<Result<Video>> getVideoById(String id);

  Future<Result<List<Video>>> getRelated(String videoId, {int limit = 5});

  Future<Result<List<Video>>> search(String query, {int limit = 20});
}
