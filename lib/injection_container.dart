import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:project_nineties/features/user/data/datasources/user_remote_datasource.dart';
import 'package:project_nineties/features/user/data/repositories/user_repository_impl.dart';
import 'package:project_nineties/features/user/domain/repositories/user_repository.dart';
import 'package:project_nineties/features/user/domain/usecases/user_usecase.dart';
import 'package:project_nineties/features/user/presentation/bloc/user_bloc/user_bloc.dart';
import 'package:project_nineties/features/authentication/data/datasources/local/authentication_local_datasource.dart';
import 'package:project_nineties/features/authentication/data/datasources/remote/authentication_remote_datasoure.dart';
import 'package:project_nineties/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:project_nineties/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:project_nineties/features/authentication/domain/usecases/authentication_usecase.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/app_bloc/app_bloc.dart';
import 'package:project_nineties/features/authentication/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:project_nineties/features/partner/data/datasources/partner_remote_datasource.dart';
import 'package:project_nineties/features/partner/data/repositories/partner_repository_impl.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_usecase.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';

final locator = GetIt.instance;
void setupLocator() {
  //blocs
  locator
      .registerFactory<AuthenticationBloc>(() => AuthenticationBloc(locator()));
  locator.registerFactory<AppBloc>(() => AppBloc(
      authenticationUseCase: locator(), authenticationInitiation: locator()));
  locator.registerFactory<PartnerBloc>(() => PartnerBloc(locator()));
  locator.registerFactory<UserBloc>(() => UserBloc(usecase: locator()));

//usecase
  locator.registerLazySingleton(() => AuthenticationUseCase(locator()));
  locator.registerLazySingleton(() => PartnerUseCase(repository: locator()));
  locator.registerLazySingleton(() => UserUseCase(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationLocalDataSource: locator(),
          authenticationRemoteDataSource: locator()));
  locator.registerLazySingleton<PartnerRepository>(
      () => PartnerRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(() =>
      AuthenticationRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<PartnerRemoteDataSource>(
      () => PartnerRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(locator(), locator(), locator()));

  //external

  locator.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
}
