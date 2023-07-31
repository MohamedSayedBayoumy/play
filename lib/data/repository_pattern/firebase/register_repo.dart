// ignore_for_file: void_checks, avoid_print, null_check_always_fails, unnecessary_null_comparison, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../models/register_model.dart';

import 'package:twitter_login/twitter_login.dart';

import '../../../core/utils/firebase_key.dart';

abstract class RegisterReopsitory {
  Future<Either<HandleFailure, UserCredential>> registerAuth(
      {RegisterModel registerModel});
  Future<Either<HandleFailure, void>> registerFireBaseDataBase(
      {RegisterModel registerModel});

  Future<Either<HandleFailure, void>> addPhoneNumberForUser(
      {required String number});

  Future<Either<HandleFailure, UserCredential>> twitter();

  Future<Either<HandleFailure, UserCredential>> google(
      {required GoogleSignIn signInGoogle});
}

class RegisterAuthByemailAndPassword implements RegisterReopsitory {
  @override
  Future<Either<HandleFailure, UserCredential>> registerAuth(
      {RegisterModel? registerModel}) async {
    try {
      final response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: registerModel!.email!, password: registerModel.password!);

      return Right(response);
    } catch (e) {
      return Left(HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString()));
    }
  }

  @override
  Future<Either<HandleFailure, void>> registerFireBaseDataBase(
      {RegisterModel? registerModel}) async {
    try {
      final sendData = FirebaseFirestore.instance
          .collection('users')
          .doc(registerModel!.uid);

      print("New User => ${registerModel.toMap()}");

      final result = await sendData.set(registerModel.toMap());
      return Right(result);
    } catch (e) {
      print("bug : ${e.toString()}");
      return Left(HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString()));
    }
  }

  @override
  Future<Either<HandleFailure, UserCredential>> twitter() async {
    try {
      final TwitterLogin twitterLogin = TwitterLogin(
        apiKey: FirebaseKey.twitterapiKeyTwitter,
        apiSecretKey: FirebaseKey.twitterapiSecretKeyTwitter,
        redirectURI: 'playapp://',
      );

      final authResult = await twitterLogin.login();

      print(
        "Twitter User : ${authResult.user!.name} - ${authResult.user!.screenName} - ${authResult.user!.thumbnailImage} , ",
      );

      if (authResult.status == TwitterLoginStatus.loggedIn) {
        await checkIfUserHaveAccount(
          email: authResult.user!.screenName,
        );

        final AuthCredential twitterAuthCredential =
            TwitterAuthProvider.credential(
                accessToken: authResult.authToken!,
                secret: authResult.authTokenSecret!);

        await FirebaseAuth.instance
            .signInWithCredential(twitterAuthCredential)
            .whenComplete(() async {
          await updataUseData(email: "${authResult.user!.screenName}@twitter.com");
        });
        final newUserCredential =
            await newCredential(email: "${authResult.user!.screenName}@twitter.com");

        return Right(newUserCredential);
      } else {
        return Left(
          HandleFirebaseConnectionError.fromFirebaseAuthException(
            "Cancel",
          ),
        );
      }
    } catch (ex) {
      if (ex == "") {}
      print("object");
      return Left(HandleFirebaseConnectionError.fromFirebaseAuthException(
          ex.toString()));
    }
  }

  @override
  Future<Either<HandleFailure, UserCredential>> google(
      {required GoogleSignIn signInGoogle}) async {
    try {
      signInGoogle.disconnect();
      GoogleSignInAccount? googleSignInAccount = await signInGoogle.signIn();
      await checkIfUserHaveAccount(
        email: googleSignInAccount!.email,
      );
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        final userCredential = await FirebaseAuth.instance
            .signInWithCredential(credential)
            .whenComplete(() async {
          await updataUseData(email: googleSignInAccount.email);
        }).whenComplete(() async {
          newCredential(email: googleSignInAccount.email);
        });

        return Right(userCredential);
      } else {
        return Left(
          HandleFirebaseConnectionError.fromFirebaseAuthException(
            "Failed to sign in , Something Failed. Please try again",
          ),
        );
      }
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }

  Future<void> checkIfUserHaveAccount({required email}) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: passwordSocialUser,
    )
        .then((value) {
      print("Check User have account > ${value.toString()}");
    });
  }

  Future<void> updataUseData({required email}) async {
    final user = FirebaseAuth.instance.currentUser;

    await user!.updatePassword(passwordSocialUser);

    await user.updateEmail(email);
  }

  Future<UserCredential> newCredential({required String email}) async {
    final newCredential = EmailAuthProvider.credential(
      email: email,
      password: passwordSocialUser,
    );

    final newCredentialUser = await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(newCredential);

    print("USER => ${newCredentialUser.user}");
    return newCredentialUser;
  }

  @override
  Future<Either<HandleFailure, void>> addPhoneNumberForUser(
      {required String number}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      print("USER => $user");

      await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .update(
        {"phoneNumber": number},
      );
      // .set({"phoneNumber": user.uid});

      return Right(user);
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }
}
