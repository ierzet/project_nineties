import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_nineties/core/utilities/constants.dart';

part 'global_cubit_state.dart';

class GlobalCubit extends Cubit<GlobalCubitState> {
  GlobalCubit() : super(GlobalCubitState.initial);

  void getResponsiveRatio({
    required double widthMax,
    required double heightMax,
  }) {
    final w = widthMax / AppDimensions.width;
    final h = heightMax / AppDimensions.height;
    final r =
        (AppDimensions.width / AppDimensions.height) / (widthMax / heightMax);
    emit(GlobalCubitState(w: w, h: h, r: r));
  }
}
