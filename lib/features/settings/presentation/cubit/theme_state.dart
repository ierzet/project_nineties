part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final Color colorSeed;

  const ThemeState({
    this.themeMode = ThemeMode.system,
    this.colorSeed = Colors.blue,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    Color? colorSeed,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      colorSeed: colorSeed ?? this.colorSeed,
    );
  }

  @override
  List<Object> get props => [themeMode, colorSeed];
}
