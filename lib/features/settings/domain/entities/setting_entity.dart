import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class SettingsEntity {
  final ThemeMode themeMode;
  final ColorSeed colorSeed;

  const SettingsEntity({
    this.themeMode = ThemeMode.light, // Default theme mode
    this.colorSeed = ColorSeed.baseColor, // Default color seed
  });

  SettingsEntity copyWith({
    ThemeMode? themeMode,
    ColorSeed? colorSeed,
  }) {
    return SettingsEntity(
      themeMode: themeMode ?? this.themeMode,
      colorSeed: colorSeed ?? this.colorSeed,
    );
  }

  // Convert to JSON for Hydrated Bloc
  Map<String, dynamic> toJson() {
    return {
      'themeMode': themeMode.index,
      'colorSeed': colorSeed.index,
    };
  }

  // Create from JSON for Hydrated Bloc
  factory SettingsEntity.fromJson(Map<String, dynamic> json) {
    return SettingsEntity(
      themeMode: ThemeMode.values[json['themeMode'] ?? 0],
      colorSeed: ColorSeed.values[json['colorSeed'] ?? 0],
    );
  }
}

// class SettingsEntity extends Equatable {
//   final ThemeMode themeMode;
//   final ColorSeed colorSeed;

//   const SettingsEntity({
//     this.themeMode = ThemeMode.system,
//     this.colorSeed = ColorSeed.teal,
//   });

//   SettingsEntity copyWith({
//     ThemeMode? themeMode,
//     ColorSeed? colorSeed,
//   }) {
//     return SettingsEntity(
//       themeMode: themeMode ?? this.themeMode,
//       colorSeed: colorSeed ?? this.colorSeed,
//     );
//   }

//   @override
//   List<Object> get props => [themeMode, colorSeed];
// }
