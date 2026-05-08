// lib/providers/user_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/localization/language_provider.dart';
import 'package:flutter_application_1/localization/en.dart';

class UserState {
  final String userLanguage;
  final Map<String, String> strings;

  UserState({
    this.userLanguage = 'en',
    Map<String, String>? strings,
  }) : strings = strings ?? en;

  UserState copyWith({
    String? userLanguage,
    Map<String, String>? strings,
  }) {
    return UserState(
      userLanguage: userLanguage ?? this.userLanguage,
      strings: strings ?? this.strings,
    );
  }
}

// class UserNotifier extends StateNotifier<UserState> {
//   UserNotifier() : super(UserState());

//   // mirrors your setUserLanguage reducer
//   void setUserLanguage(String lang) {
//     state = state.copyWith(
//       userLanguage: lang,
//       strings: getLanguagePack(lang),
//     );
//   }
// }

// final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
//   return UserNotifier();
// });