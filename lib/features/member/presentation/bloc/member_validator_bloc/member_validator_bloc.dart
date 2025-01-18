import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:project_nineties/features/member/domain/entities/member_entity.dart';

part 'member_validator_bloc_event.dart';
part 'member_validator_bloc_state.dart';

class MemberValidatorBloc
    extends Bloc<MemberValidatorBlocEvent, MemberValidatorBlocState> {
  MemberValidatorBloc() : super(MemberValidatorBlocState.empty) {
    on<MemberValidatorForm>(_onMemberValidatorForm);
    on<MemberClearValidator>(_onMemberClearValidator);
  }

  void _onMemberValidatorForm(
      MemberValidatorForm event, Emitter<MemberValidatorBlocState> emit) async {
    emit(MemberValidatorBlocState(data: event.params));
  }

  void _onMemberClearValidator(MemberClearValidator event,
      Emitter<MemberValidatorBlocState> emit) async {
    emit(MemberValidatorBlocState.empty);
  }
}


// print('Nama: ${event.params.memberName} ${event.params.isNameValid} ');
    // print('Email: ${event.params.memberEmail} ${event.params.isEmailValid} ');
    // print(
    //     'Phone: ${event.params.memberPhoneNumber} ${event.params.isPhoneValid} ');
    // print(
    //     'Gender: ${event.params.memberGender} ${event.params.isGenderValid} ');
    // print(
    //     'Address: ${event.params.memberAddress} ${event.params.isAddressValid} ');
    // print('DOB: ${event.params.memberDateOfBirth} ${event.params.isDOBValid} ');
    // // print(
    // //     'Image: ${event.params.memberPhotoOfVehicleFile} ${event.params.memberPhotoOfVehicleFile} ');
    // print(
    //     'No Vehicle: ${event.params.memberNoVehicle} ${event.params.isNoVehicleValid} ');

    // print(
    //     'Vehicle Typer: ${event.params.memberTypeOfVehicle} ${event.params.isTypeOfVehicleValid} ');
    // print(
    //     'Brand: ${event.params.memberBrandOfVehicle} ${event.params.memberBrandOfVehicle} ');
    // print(
    //     'Color: ${event.params.memberColorOfVehicle} ${event.params.isColorOfVehicleValid} ');
    // print(
    //     'Size: ${event.params.memberSizeOfVehicle} ${event.params.memberSizeOfVehicle} ');
    // print(
    //     'Member Type: ${event.params.memberTypeOfMember} ${event.params.isTypeOfMemberValid} ');
    // print(
    //     'Status: ${event.params.memberStatusMember} ${event.params.memberStatusMember} ');
    // print(
    //     'Reg: ${event.params.memberRegistrationDate} ${event.params.isRegistrationDateValid} ');
    // print(
    //     'Join: ${event.params.memberJoinDate} ${event.params.isJoinDateValid} ');
    // print(
    //     'Expried: ${event.params.memberExpiredDate} ${event.params.isExpiredDateValid} ');
    // print('File: ${event.params.isPhotoOfVehicleFileValid}');
    // print('=====================');
    // print('Partner: ${event.params.memberJoinPartner}  ');