// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:play/data/models/register_model.dart';

class LoginAuthState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  var formLoginKey = GlobalKey<FormState>();

  validation({
    required String? val,
  }) {
    if (val!.isEmpty) {
      return 'Invalid Data';
    }

    return null;
  }

  LoginAuthState({
    required this.formLoginKey,
    required this.emailController,
    required this.passwordController,
    this.errorMessage = " ",
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  LoginAuthState copyWith(
          {bool? isLoading,
          String? errorMessage,
          bool? isSuccess,
          var formLoginKey,
          bool? isFailure,
          TextEditingController? emailController,
          TextEditingController? passwordController,
          RegisterModel? registerModel}) =>
      LoginAuthState(
          emailController: emailController ?? this.emailController,
          passwordController: passwordController ?? this.passwordController,
          formLoginKey: this.formLoginKey,
          errorMessage: errorMessage ?? this.errorMessage,
          isFailure: isFailure ?? this.isFailure,
          isLoading: isLoading ?? this.isLoading,
          isSuccess: isSuccess ?? this.isSuccess);

  @override
  List<Object> get props => [
        isLoading,
        isSuccess,
        isFailure,
        errorMessage,
      ];
}
