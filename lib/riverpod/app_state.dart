class AppState {
  final bool isLoggedIn;
  final bool isFirstTime;
  final bool isLoading;

  AppState({
    required this.isLoggedIn,
    required this.isFirstTime,
    required this.isLoading,
  });

  AppState copyWith({
    bool? isLoggedIn,
    bool? isFirstTime,
    bool? isLoading,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}