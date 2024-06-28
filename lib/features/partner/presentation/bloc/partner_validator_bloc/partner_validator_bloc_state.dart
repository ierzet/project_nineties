part of 'partner_validator_bloc.dart';

class PartnerValidatorBlocState extends Equatable {
  const PartnerValidatorBlocState({
    required this.partnerParams,
  });

  final PartnerParams partnerParams;
  static final empty = PartnerValidatorBlocState(
    partnerParams: PartnerParams(
      partnerName: '',
      partnerEmail: '',
      partnerPhoneNumber: '',
      partnerAddress: '',
      partnerImageUrl: '',
      partnerStatus: '',
      partnerJoinDate: DateTime(1970, 1, 1), // or any appropriate default date
    ),
  );

  // PartnerValidatorBlocState copyWith({
  //   PartnerParams? partnerParams,
  // }) {
  //   return PartnerValidatorBlocState(
  //     partnerParams: partnerParams ?? this.partnerParams,
  //   );
  // }

  @override
  List<Object?> get props => [partnerParams];
}
