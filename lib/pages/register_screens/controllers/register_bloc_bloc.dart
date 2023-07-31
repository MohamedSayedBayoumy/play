// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../data/models/register_model.dart';
import '../../../data/repository_pattern/firebase/register_repo.dart';
import '../../../data/repository_pattern/firebase/phone_auth_repo.dart';
import 'register_bloc_event.dart';
import 'register_bloc_state.dart';

class RegisterBloc extends Bloc<RegisterBlocEvent, RegisterBlocState> {
  RegisterBloc(this.registerReopsitory, this.phoneAuthantication)
      : super(
          RegisterBlocState(
              emailController: TextEditingController(),
              phoneNumberController: TextEditingController(),
              userNameController: TextEditingController(),
              passWordController: TextEditingController(),
              confirmpassWordController: TextEditingController(),
              registerFormKey: GlobalKey<FormState>()),
        ) {
    on<RegisterByAuthenticationEvent>(_registerByAuthenticationEvent);
    on<RegisterByFirebaseDataBaseEvent>(_registerByFirebaseDataBaseEvent);
    on<RegisterByTwitterEvent>(_registerByTwitterEvent);
    on<RegisterByGoogleEvent>(_registerByGoogleEvent);
  }

  final RegisterReopsitory registerReopsitory;

  final PhoneAuthantication phoneAuthantication;

  Future<FutureOr<void>> _registerByAuthenticationEvent(
      RegisterByAuthenticationEvent event,
      Emitter<RegisterBlocState> emit) async {
    if (state.registerFormKey.currentState!.validate()) {
      emit(
        state.copyWith(
          isLoading: true,
        ),
      );

      final responseAuth = await registerReopsitory.registerAuth(
        registerModel: RegisterModel(
          email: state.emailController!.text,
          password: state.passWordController!.text,
        ),
      );

      responseAuth.fold((l) {
        emit(
          state.copyWith(
            isFaliure: true,
            isLoading: false,
            isSucces: false,
            registerModel: state.registerModel,
            errorMessage: l.message.toString(),
          ),
        );
      }, (r) async {
        add(
          RegisterByFirebaseDataBaseEvent(
            model: RegisterModel(
              uid: r.user!.uid,
              email: state.emailController!.text,
              password: state.passWordController!.text,
              userName: state.userNameController!.text,
              phoneNumber: state.phoneNumberController!.text,
            ),
          ),
        );
      });
    }
  }

  Future<FutureOr<void>> _registerByTwitterEvent(
      RegisterByTwitterEvent event, Emitter<RegisterBlocState> emit) async {
    emit(
      state.copyWith(isLoading: true, isFaliure: false, isSucces: false),
    );
    final result = await registerReopsitory.twitter();

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
            isLoading: false,
            isFaliure: true,
            errorMessage: l.message,
          ),
        );
      }
    }, (r) {
      add(
        RegisterByFirebaseDataBaseEvent(
          model: RegisterModel(
              uid: r.user!.uid,
              userName: r.user!.displayName,
              email: r.user!.email,
              phoneNumber: ""),
        ),
      );
    });
  }

  Future<FutureOr<void>> _registerByFirebaseDataBaseEvent(
      RegisterByFirebaseDataBaseEvent event,
      Emitter<RegisterBlocState> emit) async {
    final response = await registerReopsitory.registerFireBaseDataBase(
      registerModel: event.model!,
    );
    response.fold((l) {
      print(
        "ERROR : IN BLOC EVENT RegisterAuthByFirebaseDataBase",
      );
      // showMyDialog(context,
      //     title: "Error", subTitle: l.message.toString(), onPressed: () {});
    }, (r) {
      print(
        "Every thing Done",
      );
      emit(
        state.copyWith(
          isSucces: true,
          isLoading: false,
        ),
      );
    });
  }

  Future<FutureOr<void>> _registerByGoogleEvent(
      RegisterByGoogleEvent event, Emitter<RegisterBlocState> emit) async {
    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final GoogleSignIn googleSignIn = GoogleSignIn();
    googleSignIn.disconnect();

    final result = await registerReopsitory.google(signInGoogle: googleSignIn);

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
            isLoading: false,
            isFaliure: true,
            errorMessage: l.message,
          ),
        );
      }
    }, (r) {
      add(
        RegisterByFirebaseDataBaseEvent(
          model: RegisterModel(
              uid: r.user!.uid,
              userName: r.user!.displayName,
              email: r.user!.email,
              phoneNumber: ""),
        ),
      );
    });
  }
}
