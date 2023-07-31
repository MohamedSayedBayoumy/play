// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import '../../../../../../data/models/register_model.dart';

abstract class LoginAuthEvent extends Equatable {
  const LoginAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginByEmailAndPasswordEvent extends LoginAuthEvent {
  final RegisterModel registerModel;
  const LoginByEmailAndPasswordEvent({
    required this.registerModel,
  });
}

class LoginByGoogleEvent extends LoginAuthEvent {
  const LoginByGoogleEvent();
}

class LoginByTwitterEvent extends LoginAuthEvent {
  const LoginByTwitterEvent();
}

class ForgotPasswordEvent extends LoginAuthEvent {
  const ForgotPasswordEvent();
}

