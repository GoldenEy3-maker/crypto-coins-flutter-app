import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";

class HiveInitializer {
  const HiveInitializer();

  Future<String> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    return dir.path;
  }
}
