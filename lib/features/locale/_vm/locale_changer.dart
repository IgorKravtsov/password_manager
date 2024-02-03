class LocaleChanger {
  static String getNextCode(String currentLocale) {
    switch (currentLocale) {
      case 'en':
        return 'uk';
      case 'uk':
        return 'ru';
      default:
        return 'en';
    }
  }
}
