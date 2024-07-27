import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_nineties/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:project_nineties/features/customer/data/repositories/customer_repository_impl.dart';
import 'package:project_nineties/features/customer/domain/repositories/customer_repository.dart';
import 'package:project_nineties/features/customer/domain/usecases/customer_usecase.dart';
import 'package:project_nineties/features/customer/presentation/bloc/customer_bloc/customer_bloc.dart';
import 'package:project_nineties/features/transaction/data/datasources/transaction_remote_datasource.dart';
import 'package:project_nineties/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:project_nineties/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:project_nineties/features/transaction/domain/usecases/transaction_usecase.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
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
  locator.registerFactory<CustomerBloc>(() => CustomerBloc(useCase: locator()));
  locator.registerFactory<TransactionBloc>(
      () => TransactionBloc(useCase: locator()));

//usecase
  locator.registerLazySingleton(() => AuthenticationUseCase(locator()));
  locator.registerLazySingleton(() => PartnerUseCase(repository: locator()));
  locator.registerLazySingleton(() => UserUseCase(repository: locator()));
  locator.registerLazySingleton(() => CustomerUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => TransactionUseCase(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationLocalDataSource: locator(),
          authenticationRemoteDataSource: locator()));
  locator.registerLazySingleton<PartnerRepository>(
      () => PartnerRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<CustomerRepository>(
      () => CustomerRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<TransactionRepository>(
      () => TransactionRepositoryImpl(remoteDataSource: locator()));

  //data source
  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(
            locator(),
            locator(),
            locator(),
            //locator(),
          ));
  locator.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<PartnerRemoteDataSource>(
      () => PartnerRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<CustomerRemoteDataSource>(
      () => CustomerRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(locator()));

  //external

  locator.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn.standard());
}
