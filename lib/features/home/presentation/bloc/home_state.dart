part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeStateSuccessLoaded extends HomeState {
  const HomeStateSuccessLoaded({required this.data});
  final HomeEntity data;
  @override
  List<Object> get props => [data];
}
