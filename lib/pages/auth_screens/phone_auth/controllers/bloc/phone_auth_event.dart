part of 'phone_auth_bloc.dart';

abstract class PhoneAuthEvent extends Equatable {
  const PhoneAuthEvent();

  @override
  List<Object> get props => [];
}
class  GetCodeAuthPhoneEvent extends PhoneAuthEvent {
  final String number;
  final dynamic context;
  const  GetCodeAuthPhoneEvent(
      {required this.number, required this.context});
}

class SentVerificationCodeFromUser extends PhoneAuthEvent {
  final String smsCode;
  final String? revriceId;
  final String? phoneNumber;
  const SentVerificationCodeFromUser(
      {required this.smsCode, this.revriceId ,required this.phoneNumber});
}


class AddPhoneNumberForUserEvent extends PhoneAuthEvent {
  final String? phoneNumber;

  const AddPhoneNumberForUserEvent({required this.phoneNumber});
}

// class SendOtpToPhoneEvent extends RegisterBlocEvent {
//   final String phoneNumber;

//   const SendOtpToPhoneEvent({required this.phoneNumber});

//   @override
//   List<Object> get props => [phoneNumber];
// }

// // This event will be triggered when the user enters the OTP and presses the Verify OTP button on the UI.
// class VerifySentOtpEvent extends RegisterBlocEvent {
//   final String otpCode;
//   final String verificationId;

//   const VerifySentOtpEvent(
//       {required this.otpCode, required this.verificationId});

//   @override
//   List<Object> get props => [otpCode, verificationId];
// }

// // This event will be triggered when firebase sends the OTP to the user's phone number.
// class OnPhoneOtpSentEvent extends RegisterBlocEvent {
//   final String verificationId;
//   final int? token;
//   const OnPhoneOtpSentEvent({
//     required this.verificationId,
//     required this.token,
//   });

//   @override
//   List<Object> get props => [verificationId];
// }

// // This event will be triggered when any error occurs while sending the OTP to the user's phone number. This can be due to network issues or firebase's error.
// class OnPhoneAuthErrorEvent extends RegisterBlocEvent {
//   final String error;
//   const OnPhoneAuthErrorEvent({required this.error});

//   @override
//   List<Object> get props => [error];
// }

// // This event will be triggered when the verification of the OTP is successful.
// class OnPhoneAuthVerificationCompleteEvent extends RegisterBlocEvent {
//   final AuthCredential credential;
//   const OnPhoneAuthVerificationCompleteEvent({
//     required this.credential,
//   });
// }

// import 'package:firebase_auth/firebase_auth.dart';

// abstract class PhoneAuthEvent{}

// class SendOtpToPhoneEvent extends PhoneAuthEvent {
//   final String phoneNumber;

//     SendOtpToPhoneEvent({required this.phoneNumber});

//   @override
//   List<Object> get props => [phoneNumber];
// }

// class VerifySentOtpEvent extends PhoneAuthEvent {
//   final String otpCode;
//   final String verificationId;

//     VerifySentOtpEvent(
//       {required this.otpCode, required this.verificationId});

//   @override
//   List<Object> get props => [otpCode, verificationId];
// }

// class OnPhoneOtpSent extends PhoneAuthEvent {
//   final String verificationId;
//   final int? token;
//     OnPhoneOtpSent({
//     required this.verificationId,
//     required this.token,
//   });

//   @override
//   List<Object> get props => [verificationId];
// }

// class OnPhoneAuthErrorEvent extends PhoneAuthEvent {
//    final String error;
//      OnPhoneAuthErrorEvent({required this.error});

//    @override
//    List<Object> get props => [error];
// }


// class OnPhoneAuthVerificationCompleteEvent extends PhoneAuthEvent {
//    final AuthCredential credential;
//      OnPhoneAuthVerificationCompleteEvent({
//      required this.credential,
//    });
// }
