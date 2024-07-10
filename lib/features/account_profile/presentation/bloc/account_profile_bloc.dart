import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'account_profile_event.dart';
part 'account_profile_state.dart';

class AccountProfileBloc extends Bloc<AccountProfileEvent, AccountProfileState> {
  AccountProfileBloc() : super(AccountProfileInitial()) {
    on<AccountProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
