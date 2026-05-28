import 'package:get_storage/get_storage.dart';

/// Wrapper mỏng quanh `get_storage` để dễ thay backend cache.
/// Không lưu secret — chỉ cache state UI / preference.
class LocalStorage {
  LocalStorage(this._box);

  final GetStorage _box;

  static Future<LocalStorage> init() async {
    await GetStorage.init();
    return LocalStorage(GetStorage());
  }

  T? read<T>(String key) => _box.read<T>(key);

  Future<void> write(String key, Object? value) => _box.write(key, value);

  Future<void> remove(String key) => _box.remove(key);

  bool has(String key) => _box.hasData(key);
}
