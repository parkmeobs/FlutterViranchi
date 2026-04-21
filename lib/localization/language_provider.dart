// lib/l10n/language_pack.dart
// import 'strings_en.dart';
// import 'strings_hi.dart';
import 'package:flutter_application_1/localization/en.dart';
import 'package:flutter_application_1/localization/hi.dart';
Map<String, String> getLanguagePack(String lang) {
  switch (lang) {
    case 'hi':
      return hi;
    case 'en':
    default:
      return en;
  }
}