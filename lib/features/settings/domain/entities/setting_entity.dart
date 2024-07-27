import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/core/utilities/constants.dart';

class SettingsEntity extends Equatable {
  final ThemeMode themeMode;
  final ColorSeed colorSeed;

  const SettingsEntity({
    this.themeMode = ThemeMode.system,
    this.colorSeed = ColorSeed.teal,
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

  @override
  List<Object> get props => [themeMode, colorSeed];
}
