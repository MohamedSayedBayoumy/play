// ignore_for_file: void_checks, avoid_print, null_check_always_fails

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import '../../../core/errors/handle_errors.dart';
import '../../../core/utils/app_constance/app_constance.dart';
import '../../../core/utils/firebase_key.dart';
import '../../models/register_model.dart';

abstract class LoginRepository {
  Future<Either<HandleFailure, void>> loginAuth({RegisterModel registerModel});

  Future<Either<HandleFailure, void>> loginAuthByGoogle(
      {required GoogleSignIn signInGoogle});

  Future<Either<HandleFailure, void>> loginAuthByTwitter();
}

class LoginByFirebase implements LoginRepository {
  @override
  Future<Either<HandleFailure, void>> loginAuth(
      {RegisterModel? registerModel}) async {
    try {
      final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: registerModel!.email!, password: registerModel.password!);

      return Right(response);
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<HandleFailure, void>> loginAuthByGoogle(
      {required GoogleSignIn signInGoogle}) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await signInGoogle.signIn();
      final response = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: googleSignInAccount!.email,
        password: passwordSocialUser,
      )
          .then((userData) {
        print("User => ${userData.user!}");
      });

      return Right(response);
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<HandleFailure, void>> loginAuthByTwitter() async {
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
        final response = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: authResult.user!.screenName,
          password: passwordSocialUser,
        );
        return Right(response);
      } else if (authResult.status == TwitterLoginStatus.cancelledByUser) {
        return null!;
      } else {
        return null!;
      }
    } catch (e) {
      return Left(
        HandleFirebaseConnectionError.fromFirebaseAuthException(
          e.toString(),
        ),
      );
    }
  }
}
