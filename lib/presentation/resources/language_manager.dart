enum LanguageType { ENGLISH, MARATHI }

const String MARATHI = 'mr';
const String ENGLISH = 'en';

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return ENGLISH;
      case LanguageType.MARATHI:
        return MARATHI;
    }
  }
}
