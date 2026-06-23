// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Crypto App';

  @override
  String homeTitleWithValue(String value) {
    return 'Home: $value';
  }

  @override
  String get bottomNavigationBarHome => 'Home';

  @override
  String get bottomNavigationBarCoins => 'Coins';

  @override
  String get bottomNavigationBarSettings => 'Settings';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get systemTheme => 'System';
}
