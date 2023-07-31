import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:play/data/repository_pattern/firebase/login_repo.dart';
import 'package:play/data/repository_pattern/firebase/phone_auth_repo.dart';

import 'login_auth_event.dart';
import 'login_auth_state.dart';

class LoginAuthBloc extends Bloc<LoginAuthEvent, LoginAuthState> {
  LoginAuthBloc(this.loginRepository, this.phoneAuthantication)
      : super(LoginAuthState(
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            formLoginKey: GlobalKey<FormState>())) {
    on<LoginByEmailAndPasswordEvent>(_loginByEmailAndPasswordEvent);
    on<LoginByGoogleEvent>(_loginByGoogleEvent);
    on<LoginByTwitterEvent>(_loginByTwitterEvent);
  }

  final LoginRepository loginRepository;

  final PhoneAuthantication phoneAuthantication;

  Future<FutureOr<void>> _loginByEmailAndPasswordEvent(
      LoginByEmailAndPasswordEvent event, Emitter<LoginAuthState> emit) async {
    if (state.formLoginKey.currentState!.validate()) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );

      final result =
          await loginRepository.loginAuth(registerModel: event.registerModel);

      result.fold((l) {
        emit(
          state.copyWith(
            isLoading: false,
            isFailure: true,
            errorMessage: l.message,
          ),
        );
      }, (r) {
        emit(
          state.copyWith(
            isLoading: false,
            isSuccess: true,
          ),
        );
      });
    }
  }

  Future<FutureOr<void>> _loginByGoogleEvent(
      LoginByGoogleEvent event, Emitter<LoginAuthState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();

    final result =
        await loginRepository.loginAuthByGoogle(signInGoogle: googleSignIn);

    result.fold((l) {
      emit(
        state.copyWith(
            isLoading: false, isFailure: true, errorMessage: l.message),
      );
    }, (r) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
        ),
      );
    });
  }

  Future<FutureOr<void>> _loginByTwitterEvent(
      LoginByTwitterEvent event, Emitter<LoginAuthState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );
    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();

    final result = await loginRepository.loginAuthByTwitter();

    result.fold((l) {
      if (l.message == "Null check operator used on a null value") {
        emit(
          state.copyWith(
            isLoading: false,
          ),
        );
      } else {
        emit(
          state.copyWith(
              isLoading: false, isFailure: true, errorMessage: l.message),
        );
      }
    }, (r) {
      emit(
        state.copyWith(
          isLoading: false,
          isSuccess: true,
        ),
      );
    });
  }
}
