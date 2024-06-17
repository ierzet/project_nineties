import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project_nineties/features/authentication/data/datasources/local/authentication_local_datasource.dart';
import 'package:project_nineties/features/authentication/data/datasources/remote/authentication_remote_datasoure.dart';
import 'package:project_nineties/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

final locator = GetIt.instance;
void setupLocator() {
  //blocs
  locator
      .registerFactory<AuthenticationBloc>(() => AuthenticationBloc(locator()));

//usecase
  locator.registerLazySingleton(() => AuthenticationUseCase(locator()));

  //repository
  locator.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationLocalDataSource: locator(),
          authenticationRemoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(() =>
      AuthenticationRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(locator()));

  //external

  locator.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
}
