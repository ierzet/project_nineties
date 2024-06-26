part of 'global_cubit.dart';

class GlobalCubitState extends Equatable {
  final double w;
  final double h;
  final double r;

  const GlobalCubitState({required this.w, required this.h, required this.r});

  static const initial = GlobalCubitState(
    w: 1,
    h: 1,
    r: 1,
  );

  GlobalCubitState copyWith({
    double? w,
    double? h,
    double? r,
  }) {
    return GlobalCubitState(
      w: w ?? this.w,
      h: h ?? this.h,
      r: r ?? this.r,
    );
  }

  @override
  List<Object?> get props => [w, h, r];
}
