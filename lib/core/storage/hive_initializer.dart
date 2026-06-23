import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

/// Инициализация Hive в каталоге приложения ([Hive.init]).
class HiveInitializer {
  const HiveInitializer();

  /// Возвращает путь к каталогу данных, где поднят Hive.
  Future<String> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return dir.path;
  }
}
