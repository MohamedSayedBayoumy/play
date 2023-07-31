// ignore_for_file: avoid_print, non_constant_identifier_names, avoid_types_as_parameter_names

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:play/data/repository_pattern/firebase/register_repo.dart';

import '../../../../../core/functions/snak_bar.dart';
import '../../../../../data/repository_pattern/firebase/phone_auth_repo.dart';
import '../../../../../main.dart';

part 'phone_auth_event.dart';
part 'phone_auth_state.dart';

class PhoneAuthBloc extends Bloc<PhoneAuthEvent, PhoneAuthState> {
  PhoneAuthBloc(this.phoneAuthantication, this.registerReopsitory)
      : super(PhoneAuthState(
            phoneController: TextEditingController(),
            auth: FirebaseAuth.instance)) {
    on<GetCodeAuthPhoneEvent>(_getCodeAuthPhoneEvent);
    on<SentVerificationCodeFromUser>(_sentVerificationCodeFromUser);
    on<AddPhoneNumberForUserEvent>(_addPhoneNumberForUserEvent);
    // on<LoginByPhoneNumberEvent>(_loginByPhoneNumberEvent);
  }
  final PhoneAuthantication phoneAuthantication;
  final RegisterReopsitory registerReopsitory;

  Future<FutureOr<void>> _getCodeAuthPhoneEvent(
      GetCodeAuthPhoneEvent event, Emitter<PhoneAuthState> emit) async {
    try {
      emit(
        state.copyWith(isLoading: true),
      );
      await phoneAuthantication
          .getVerificationCode(
        phoneNumber: event.number,
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '';
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          prefs.setString("verificationId", verificationId);

          print("credential:  ${credential.verificationId}");
        },
        verificationFailed: (p0) {
          if (p0.code ==
              " [firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.") {
            snackBar(
              event.context,
              message:
                  "We have blocked all requests cause many request, please try again later",
              isFailure: true,
            );
          } else {
            snackBar(
              event.context,
              message: "Something has gone wrong, please try again later",
              isFailure: true,
            );
          }
          print("Error : ${p0.toString()}");
        },
        codeAutoRetrievalTimeout: (String) {},
        verificationCompleted: (PhoneAuthCredential credential) {},
      )
          .whenComplete(() {
        emit(
          state.copyWith(isLoading: false),
        );
      });
    } catch (e) {
      emit(
        state.copyWith(
          isFailure: true,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  FutureOr<void> _sentVerificationCodeFromUser(
      SentVerificationCodeFromUser event, Emitter<PhoneAuthState> emit) async {
    emit(
      state.copyWith(
        isFailure: false,
        isLoading: true,
      ),
    );

    final result = await phoneAuthantication.sendVerificationCode(
      smsCode: event.smsCode,
      phoneNumber: event.phoneNumber!,
    );

    result.fold((l) {
      emit(
        state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: l.message,
        ),
      );
    }, (r) {
      if (state.phoneController!.text.isEmpty) {
        add(
          AddPhoneNumberForUserEvent(
            phoneNumber: event.phoneNumber,
          ),
        );
      } else {
        emit(
          state.copyWith(
            isSuccess: true,
            isLoading: false,
          ),
        );
      }
    });
  }

  Future<FutureOr<void>> _addPhoneNumberForUserEvent(
      AddPhoneNumberForUserEvent event, Emitter<PhoneAuthState> emit) async {
    final result = await registerReopsitory.addPhoneNumberForUser(
      number: event.phoneNumber!,
    );

    result.fold((l) {
      emit(
        state.copyWith(
          isLoading: false,
          isFailure: true,
          errorMessage: l.message,
        ),
      );
    }, (r) {});
  }

 
}
