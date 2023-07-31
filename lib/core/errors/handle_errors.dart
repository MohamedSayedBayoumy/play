// ignore_for_file: deprecated_member_use, avoid_print

import 'package:dio/dio.dart';

abstract class HandleFailure {
  String? message;
  HandleFailure(this.message);
}

class HandleInternetConnectionError extends HandleFailure {
  HandleInternetConnectionError(super.message);

  factory HandleInternetConnectionError.fromDioExceptionType(
      DioExceptionType dioError) {
    switch (dioError) {
      case DioExceptionType.badCertificate:
        return HandleInternetConnectionError("badCertificate");
      case DioExceptionType.connectionError:
        return HandleInternetConnectionError("connectionError");
      case DioExceptionType.connectionTimeout:
        return HandleInternetConnectionError("connection Time out");
      case DioExceptionType.sendTimeout:
        return HandleInternetConnectionError("send Time out");
      case DioExceptionType.receiveTimeout:
        return HandleInternetConnectionError("receiveTimeout");
      case DioExceptionType.cancel:
        return HandleInternetConnectionError("cancel");
      case DioExceptionType.badResponse:
        return HandleInternetConnectionError("bad Response");
      case DioExceptionType.unknown:
        return HandleInternetConnectionError(dioError.toString());

      // return HandleInternetConnectionError(
      //     "Check your Internet connection and try again");

      default:
        return HandleInternetConnectionError(
            "Some thing is wrong , please try again laterr");
    }
  }
}

class HandleFirebaseConnectionError extends HandleFailure {
  HandleFirebaseConnectionError(super.message);
  factory HandleFirebaseConnectionError.fromFirebaseAuthException(
      String error) {
    if (error.toString() ==
        "[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
      print(
        error.toString(),
      );
      return HandleFirebaseConnectionError(
        "Please check your Internet connection and try again",
      );
    } else if (error.toString() ==
        "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
      print(
        error.toString(),
      );
      return HandleFirebaseConnectionError(
        "The email address is already in use by another account",
      );
    } else if (error.toString() ==
        "[firebase_auth/weak-password] Password should be at least 6 characters") {
      return HandleFirebaseConnectionError(
        "Password should be at least 6 characters",
      );
    } else if (error.toString() ==
        "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
      return HandleFirebaseConnectionError(
        "User Not Found , Please try again with a different account",
      );
    } else if (error.toString() == "Null check operator used on a null value") {
      print(" ${error.toString()}");

      return HandleFirebaseConnectionError(
        error.toString(),
      );
    } else if (error.toString() ==
        "[firebase_auth/session-expired] The sms code has expired. Please re-send the verification code to try again.") {
      return HandleFirebaseConnectionError(
        "The sms code has expired. Please re-send the verification code to try again",
      );
    } else {
      print("Else Failed : ${error.toString()}");

      return HandleFirebaseConnectionError(error.toString());
    }
  }
}
