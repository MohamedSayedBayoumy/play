// ignore_for_file: must_be_immutable, unnecessary_this

import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../data/models/register_model.dart';

class RegisterBlocState extends Equatable {
  final TextEditingController? userNameController;
  final TextEditingController? emailController;
  final TextEditingController? phoneNumberController;
  final TextEditingController? passWordController;
  final TextEditingController? confirmpassWordController;

  var registerFormKey = GlobalKey<FormState>();

  String receivedID = "";

  String errorMessage = "";
  bool isLoading = false;
  bool isSucces = false;
  bool isFaliure = false;

  RegisterModel? registerModel = RegisterModel();

  errorEmail({required String val}) {
    !EmailValidator.validate(val) ? 'Invaild Data' : null;
    if (val.isEmpty) {
      return 'Invaild Data';
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)) {
      return 'Must Your Email include @play.com';
    }
    return null;
  }

  validation({
    required String? val,
  }) {
    if (val!.isEmpty) {
      return 'Invalid Data';
    }
    if (confirmpassWordController!.text != passWordController!.text) {
      return 'Invalid Data , Should be a same password';
    }
    return null;
  }

  phoneNumberFormat(
      {required String value, required TextEditingController controller}) {
    if (value == "0") {
      controller.clear();
    }
  }

  RegisterBlocState({
    this.registerModel,
    this.confirmpassWordController,
    this.emailController,
    this.phoneNumberController,
    required this.registerFormKey,
    this.userNameController,
    this.passWordController,
    this.receivedID = " ",
    this.errorMessage = " ",
    this.isFaliure = false,
    this.isSucces = false,
    this.isLoading = false,
  });

  RegisterBlocState copyWith(
          {TextEditingController? passWordController,
          TextEditingController? confirmpassWordController,
          TextEditingController? userNameController,
          TextEditingController? emailController,
          TextEditingController? phoneNumberController,
          String? receivedID,
          FirebaseAuth? auth,
          String? errorMessage,
          RegisterModel? registerModel,
          bool? isSucces,
          bool? isFaliure,
          bool? isLoading}) =>
      RegisterBlocState(
          registerFormKey: this.registerFormKey,
          emailController: emailController ?? this.emailController,
          phoneNumberController:
              phoneNumberController ?? this.phoneNumberController,
          userNameController: userNameController ?? this.userNameController,
          registerModel: registerModel ?? this.registerModel,
          errorMessage: errorMessage ?? this.errorMessage,
          passWordController: passWordController ?? this.passWordController,
          confirmpassWordController:
              confirmpassWordController ?? this.confirmpassWordController,
          receivedID: receivedID ?? this.receivedID,
          isLoading: isLoading ?? this.isLoading,
          isFaliure: isFaliure ?? this.isFaliure,
          isSucces: isSucces ?? this.isSucces);

  @override
  List<Object> get props => [
        passWordController!,
        confirmpassWordController!,
        receivedID,
        isFaliure,
        isSucces,
        isLoading,
        
      ];
}
