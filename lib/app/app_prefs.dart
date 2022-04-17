import 'package:mvvm_demo/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  SharedPreferences _sharedPreferences;
  AppPreferences(this._sharedPreferences);

  /// This will return the selected app language from shared prefs
  /// otherwise it will return default language as English
  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(PREFS_KEY_LANGUAGE);
    if (language!=null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }
}

const String PREFS_KEY_LANGUAGE = 'PREFS_KEY_LANGUAGE';