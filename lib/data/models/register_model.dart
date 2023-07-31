import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  final String? userName;
  final String? email;
  final String? phoneNumber;
  final String? password;
  final String? uid;
  const RegisterModel({
    this.userName = "",
    this.uid = " ",
    this.email = " ",
    this.phoneNumber = " ",
    this.password = "",
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password
    };
  }

  @override
  List<Object?> get props => [userName, email, phoneNumber, password, uid];
}
