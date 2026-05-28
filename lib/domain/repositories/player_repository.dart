import '../../core/error/result.dart';
import '../entities/player.dart';

abstract interface class PlayerRepository {
  Future<Result<List<Player>>> getSquad();

  Future<Result<Player>> getPlayerById(String id);
}
