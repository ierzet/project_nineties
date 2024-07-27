import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';
import 'package:project_nineties/features/settings/domain/entities/setting_entity.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<SettingsEntity> {
  ThemeCubit() : super(const SettingsEntity());

  void setThemeMode(ThemeMode mode) {
    emit(state.copyWith(themeMode: mode));
  }

  void setColorSeed(ColorSeed colorSeed) {
    emit(state.copyWith(colorSeed: colorSeed));
  }
}
