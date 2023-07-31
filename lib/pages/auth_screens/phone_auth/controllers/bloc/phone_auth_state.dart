// ignore_for_file: must_be_immutable

part of 'phone_auth_bloc.dart';

class PhoneAuthState extends Equatable {
  final TextEditingController? phoneController;

  String receivedID = "";

  String errorMessage = "";
  bool isLoading = false;
  bool isSuccess = false;
  bool isFailure = false;
  FirebaseAuth? auth;

  PhoneAuthState(
      {this.phoneController,
      this.receivedID = " ",
      this.errorMessage = " ",
      this.isFailure = false,
      this.isSuccess = false,
      this.isLoading = false,
      this.auth});

  PhoneAuthState copyWith(
          {TextEditingController? phoneController,
          String? receivedID,
          FirebaseAuth? auth,
          String? errorMessage,
          bool? isSuccess,
          bool? isFailure,
          bool? isLoading}) =>
      PhoneAuthState(
          auth: auth ?? this.auth,
          errorMessage: errorMessage ?? this.errorMessage,
          phoneController: phoneController ?? this.phoneController,
          receivedID: receivedID ?? this.receivedID,
          isLoading: isLoading ?? this.isLoading,
          isFailure: isFailure ?? this.isFailure,
          isSuccess: isSuccess ?? this.isSuccess);

  @override
  List<Object> get props => [
        phoneController!,
        receivedID,
        isFailure,
        isSuccess,
        isLoading,
      ];
}
