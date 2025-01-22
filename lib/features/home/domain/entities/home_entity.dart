import 'package:equatable/equatable.dart';

class HomeEntity extends Equatable {
  const HomeEntity({
    required this.totalMembers,
    required this.totalPartners,
    required this.totalUsers,
    required this.totalTransactions,
  });

  final int totalMembers;
  final int totalPartners;
  final int totalUsers;
  final int totalTransactions;

  // Static constant for an empty instance
  static const empty = HomeEntity(
    totalMembers: 0,
    totalPartners: 0,
    totalUsers: 0,
    totalTransactions: 0,
  );

  bool get isEmpty => this == HomeEntity.empty;
  bool get isNotEmpty => this != HomeEntity.empty;

  @override
  List<Object?> get props =>
      [totalMembers, totalPartners, totalUsers, totalTransactions];

  HomeEntity copyWith({
    int? totalMembers,
    int? totalPartners,
    int? totalUsers,
    int? totalTransactions,
  }) {
    return HomeEntity(
      totalMembers: totalMembers ?? this.totalMembers,
      totalPartners: totalPartners ?? this.totalPartners,
      totalUsers: totalUsers ?? this.totalUsers,
      totalTransactions: totalTransactions ?? this.totalTransactions,
    );
  }
}
