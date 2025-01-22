import 'package:project_nineties/features/home/domain/entities/home_entity.dart';

// HomeModel class extending HomeEntity
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.totalMembers,
    required super.totalPartners,
    required super.totalUsers,
    required super.totalTransactions,
  });

  // Static constant for an empty instance
  static const empty = HomeModel(
    totalMembers: 0,
    totalPartners: 0,
    totalUsers: 0,
    totalTransactions: 0,
  );

  HomeEntity toEntity() => HomeModel(
        totalMembers: totalMembers,
        totalPartners: totalPartners,
        totalUsers: totalUsers,
        totalTransactions: totalTransactions,
      );
  @override
  bool get isEmpty => this == HomeModel.empty;
  @override
  bool get isNotEmpty => this != HomeModel.empty;

  @override
  HomeModel copyWith({
    int? totalMembers,
    int? totalPartners,
    int? totalUsers,
    int? totalTransactions,
  }) {
    return HomeModel(
      totalMembers: totalMembers ?? this.totalMembers,
      totalPartners: totalPartners ?? this.totalPartners,
      totalUsers: totalUsers ?? this.totalUsers,
      totalTransactions: totalTransactions ?? this.totalTransactions,
    );
  }

  // Example method to convert HomeModel to a Map (for serialization)
  Map<String, dynamic> toMap() {
    return {
      'totalMembers': totalMembers,
      'totalPartners': totalPartners,
      'totalUsers': totalUsers,
      'totalTransactions': totalTransactions,
    };
  }

  // Example method to create a HomeModel from a Map (for deserialization)
  factory HomeModel.fromMap(Map<String, dynamic> map) {
    return HomeModel(
      totalMembers: map['totalMembers'] ?? 0,
      totalPartners: map['totalPartners'] ?? 0,
      totalUsers: map['totalUsers'] ?? 0,
      totalTransactions: map['totalTransactions'] ?? 0,
    );
  }
}
