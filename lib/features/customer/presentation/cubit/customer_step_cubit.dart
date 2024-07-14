import 'package:bloc/bloc.dart';

class CustomerStepCubit extends Cubit<int> {
  CustomerStepCubit() : super(0);

  void goToStep(int step) => emit(step);
  void nextStep() => emit(state + 1);
  void previousStep() => emit(state - 1);
}

