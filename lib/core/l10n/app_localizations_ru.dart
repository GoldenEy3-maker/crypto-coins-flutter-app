// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Вайбик крипты';

  @override
  String homeTitleWithValue(String value) {
    return 'Главная: $value';
  }

  @override
  String get bottomNavigationBarHome => 'Главная';

  @override
  String get bottomNavigationBarCoins => 'Монеты';

  @override
  String get bottomNavigationBarSettings => 'Настройки';

  @override
  String get lightTheme => 'Светлая';

  @override
  String get darkTheme => 'Тёмная';

  @override
  String get systemTheme => 'Системная';
}
