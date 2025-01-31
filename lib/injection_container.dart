import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project_nineties/features/home/data/datasources/home_remote_datasource.dart';
import 'package:project_nineties/features/home/data/repositories/home_repository_impl.dart';
import 'package:project_nineties/features/home/domain/repositories/home_repository.dart';
import 'package:project_nineties/features/home/domain/usecases/home_usecase.dart';
import 'package:project_nineties/features/home/presentation/cubit/home_cubit.dart';
import 'package:project_nineties/features/member/data/datasources/local/member_local_datasource.dart';
import 'package:project_nineties/features/member/data/datasources/remote/member_remote_datasource.dart';
import 'package:project_nineties/features/member/data/repositories/member_repository_impl.dart';
import 'package:project_nineties/features/member/domain/repositories/member_repository.dart';
import 'package:project_nineties/features/member/domain/usecases/member_usecase.dart';
import 'package:project_nineties/features/member/presentation/bloc/member_bloc/member_bloc.dart';
import 'package:project_nineties/features/message/data/datasources/message_remote_datasoource.dart';
import 'package:project_nineties/features/message/data/repositories/message_repository_impl.dart';
import 'package:project_nineties/features/message/domain/repositories/message_repository.dart';
import 'package:project_nineties/features/message/domain/usecases/message_usecase.dart';
import 'package:project_nineties/features/message/presentation/bloc/message_bloc.dart';
import 'package:project_nineties/features/partner/data/datasources/local/partner_local_datasource.dart';
import 'package:project_nineties/features/transaction/data/datasources/local/transaction_local_datasource.dart';
import 'package:project_nineties/features/transaction/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:project_nineties/features/transaction/data/repositories/transaction_repository_impl.dart';
import 'package:project_nineties/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:project_nineties/features/transaction/domain/usecases/transaction_usecase.dart';
import 'package:project_nineties/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:project_nineties/features/user/data/datasources/local/user_local_datasource.dart';
import 'package:project_nineties/features/user/data/datasources/remote/user_remote_datasource.dart';
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
import 'package:project_nineties/features/partner/data/datasources/remote/partner_remote_datasource.dart';
import 'package:project_nineties/features/partner/data/repositories/partner_repository_impl.dart';
import 'package:project_nineties/features/partner/domain/repositories/pertner_repository.dart';
import 'package:project_nineties/features/partner/domain/usecases/partner_usecase.dart';
import 'package:project_nineties/features/partner/presentation/bloc/partner_bloc/partner_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;
void setupLocator() {
  //blocs
  locator
      .registerFactory<AuthenticationBloc>(() => AuthenticationBloc(locator()));
  locator.registerFactory<AppBloc>(() => AppBloc(
      authenticationUseCase: locator(), authenticationInitiation: locator()));
  locator.registerFactory<PartnerBloc>(() => PartnerBloc(locator()));
  locator.registerFactory<UserBloc>(() => UserBloc(usecase: locator()));
  locator.registerFactory<MemberBloc>(() => MemberBloc(useCase: locator()));
  locator.registerFactory<TransactionBloc>(
      () => TransactionBloc(useCase: locator()));
  locator.registerFactory<MessageBloc>(() => MessageBloc(useCase: locator()));
  locator.registerFactory<HomeCubit>(() => HomeCubit(useCase: locator()));

//usecase
  locator.registerLazySingleton(() => AuthenticationUseCase(locator()));
  locator.registerLazySingleton(() => PartnerUseCase(repository: locator()));
  locator.registerLazySingleton(() => UserUseCase(repository: locator()));
  locator.registerLazySingleton(() => MemberUseCase(repository: locator()));
  locator
      .registerLazySingleton(() => TransactionUseCase(repository: locator()));
  locator.registerLazySingleton(() => MessageUseCase(repository: locator()));
  locator.registerLazySingleton(() => HomeUseCase(repository: locator()));

  //repository
  locator.registerLazySingleton<AuthenticationRepository>(() =>
      AuthenticationRepositoryImpl(
          authenticationLocalDataSource: locator(),
          authenticationRemoteDataSource: locator()));
  locator.registerLazySingleton<PartnerRepository>(() => PartnerRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));
  locator.registerLazySingleton<MemberRepository>(() => MemberRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));
  locator.registerLazySingleton<TransactionRepository>(() =>
      TransactionRepositoryImpl(
          remoteDataSource: locator(), localDataSource: locator()));
  locator.registerLazySingleton<MessageRepository>(
      () => MessageRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImpl(remoteDatasource: locator()));

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
      () => PartnerRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<PartnerLocalDataSource>(
      () => PartnerLocalDataSourceImpl());
  locator.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(locator(), locator(), locator()));
  locator.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl());
  locator.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(locator(), locator()));
  locator.registerLazySingleton<MemberLocalDataSource>(
      () => MemberLocalDataSourceImpl());
  locator.registerLazySingleton<TransactionRemoteDataSource>(
      () => TransactionRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<TransactionLocalDataSource>(
      () => TransactionLocalDataSourceImpl());
  locator.registerLazySingleton<MessaggeRemoteDataSource>(
      () => MessaggeRemoteDataSourceImpl(locator()));
  locator.registerLazySingleton<HomeRemoteDatasource>(
      () => HomeRemoteDatasourceImpl(locator()));

  //external

  locator.registerLazySingleton(() => firebase_auth.FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn.standard());
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Dio());
}
