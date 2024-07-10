part of 'account_profile_bloc.dart';

abstract class AccountProfileState extends Equatable {
  const AccountProfileState();  

  @override
  List<Object> get props => [];
}
class AccountProfileInitial extends AccountProfileState {}
