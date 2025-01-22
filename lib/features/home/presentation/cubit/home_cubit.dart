import 'package:bloc/bloc.dart';
import 'package:project_nineties/features/home/domain/entities/home_entity.dart';
import 'package:project_nineties/features/home/domain/usecases/home_usecase.dart';



class HomeCubit extends Cubit<HomeEntity> {
  HomeCubit({required this.useCase}) : super(HomeEntity.empty);

  final HomeUseCase useCase;

  Future<void> count() async {
    final result = await useCase.count();
    result.fold(
      (failure) {
        emit(HomeEntity.empty);
      },
      (data) {
        emit(data);
      },
    );
  }
}

