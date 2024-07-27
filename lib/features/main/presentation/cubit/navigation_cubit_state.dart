import 'package:equatable/equatable.dart';
import 'package:project_nineties/features/authentication/domain/entities/user_account_entity.dart';

class NavigationCubitState extends Equatable {
  const NavigationCubitState({
    required this.indexBotNavBar,
    this.subMenuProfileOpt,
  });

  final int indexBotNavBar;
  final String? subMenuProfileOpt;

  static NavigationCubitState initial =
      const NavigationCubitState(indexBotNavBar: 0);

  NavigationCubitState copyWith({
    int? indexBotNavBar,
    String? subMenuProfileOpt,
    UserAccountEntity? userAccountEntity, // Tambahkan ini
  }) {
    return NavigationCubitState(
      indexBotNavBar: indexBotNavBar ?? this.indexBotNavBar,
      subMenuProfileOpt: subMenuProfileOpt ?? this.subMenuProfileOpt,
    );
  }

  @override
  List<Object?> get props => [
        indexBotNavBar,
        subMenuProfileOpt,
      ];
}
