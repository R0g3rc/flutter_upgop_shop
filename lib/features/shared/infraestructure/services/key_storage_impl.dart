import 'package:crud_app/features/shared/infraestructure/services/key_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyStorageImpl extends KeyStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case const (int):
        return prefs.getInt(key) as T?;
      case const (String):
        return prefs.getString(key) as T?;
      default:
        throw UnimplementedError('GET Type ${T.runtimeType} is not supported');
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case const (int):
        prefs.setInt(key, value as int);
        break;
      case const (String):
        prefs.setString(key, value as String);
        break;
      default:
        throw UnimplementedError('SET Type ${T.runtimeType} is not supported');
    }
  }
}
