import "package:shared_preferences/shared_preferences.dart";

class PrefsInitializer {
  const PrefsInitializer();

  Future<SharedPreferences> init() async {
    return SharedPreferences.getInstance();
  }
}
