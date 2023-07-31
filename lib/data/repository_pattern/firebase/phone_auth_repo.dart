// ignore_for_file: avoid_print, null_check_always_fails

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/handle_errors.dart';

import '../../../main.dart';

abstract class PhoneAuthantication {
  Future<void> getVerificationCode({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  });

  Future<Either<HandleFailure, PhoneAuthCredential>> sendVerificationCode({
    required String smsCode,
    required String phoneNumber,
  });

  // Future<Either<HandleFailure, UserCredential>> loginByPhoneNumber({
  //   required String phoneNumber,
  // });
}

class AuthUserByPhoneNumber implements PhoneAuthantication {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<void> getVerificationCode({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  @override
  Future<Either<HandleFailure, PhoneAuthCredential>> sendVerificationCode({
    required String smsCode,
    required String phoneNumber,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: prefs.getString("verificationId").toString(),
        smsCode: smsCode,
      );

      // final response =
      //     await FirebaseAuth.instance.signInWithCredential(credential);

      return Right(credential);
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }

  // @override
  // Future<Either<HandleFailure, UserCredential>> loginByPhoneNumber(
  //     {required String phoneNumber}) async {
  //   try {
  //     final response =
  //         await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: phoneNumber,
  //       password: passwordSocialUser,
  //     );
  //     return Right(response);
  //   } catch (e) {
  //     return Left(
  //       HandleFirebaseConnectionError.fromFirebaseAuthException(
  //         e.toString(),
  //       ),
  //     );
  //   }
  // }
}
