// ignore_for_file: null_check_always_fails

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/services/service_get_it.dart';
import '../../../../../../core/text_styles/text_style.dart';
import '../../../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../../../core/widgets/custom_button.dart';
import '../../../../../../core/widgets/custom_navigation.dart';
import '../../../../../../core/widgets/custom_social_button.dart';
import '../../../../../../core/widgets/cutom_text_field/custom_text_filed.dart';

import '../../../core/functions/alert_dialog.dart';
import '../../../core/functions/snak_bar.dart';

import '../../../core/utils/app_constance/color_constance.dart';
import '../../../data/models/register_model.dart';
import '../../register_screens/screens/register_by_email_and_password.dart';
import '../controllers/login_auth_bloc.dart';
import '../controllers/login_auth_event.dart';
import '../controllers/login_auth_state.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(40, media.height * .085, 40, 8),
          child: BlocProvider(
            create: (context) => sl<LoginAuthBloc>(),
            child: BlocConsumer<LoginAuthBloc, LoginAuthState>(
              listener: (context, state) {
                if (state.isLoading == true) {
                  showMyDialog(context,
                      barrierDismissible: false,
                      needBackgroundColor: false,
                      content: Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Theme.of(context).primaryColor,
                            color: ColorConstance.cDefaultColor),
                      ));
                } else if (state.isSuccess == true) {
                  Navigator.pop(context);
                  snackBar(
                    context,
                    message: "Successfully",
                    isSuccess: true,
                  );
                } else if (state.isFailure == true) {
                  Navigator.pop(context);

                  snackBar(
                    context,
                    message: state.errorMessage.toString(),
                    isFailure: true,
                  );
                } else {
                  Navigator.pop(context);
                }
                // print("Something went wrong in Login BLoc");
              },
              builder: (context, state) {
                final bloc = BlocProvider.of<LoginAuthBloc>(context);
                return Form(
                  key: state.formLoginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login in ",
                        style: largeStyleSize.copyWith(
                            color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 30),
                      CustomTextField(
                        hinText: "example@example.com",
                        labelText: "E-mail",
                        valid: (p0) => state.validation(val: p0),
                        controller: state.emailController,
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        hinText: "abc*****",
                        labelText: "Password",
                        suffixIcon: true,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        maxLength: 1,
                        valid: (p0) => state.validation(val: p0),
                        controller: state.passwordController,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                              onTap: () {
                                AnimationRoute.slideRoute(
                                  context,
                                  pageRoute: ForgotPasswordScreen(),
                                );
                              },
                              child: const Text(
                                "Forgot your password ? ",
                                style: smallTextStyleAuthScreens,
                              ))
                        ],
                      ),
                      const SizedBox(height: 60),
                      customButton(
                        text: "Login",
                        width: media.width,
                        onPressed: () {
                          bloc.add(
                            LoginByEmailAndPasswordEvent(
                              registerModel: RegisterModel(
                                email: state.emailController!.text,
                                password: state.passwordController!.text,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                'By clicking the "Log in" button , you accept',
                            style: smallTextStyleAuthScreens.copyWith(
                                fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Privacy Policy ',
                                style: smallTextStyleAuthScreens.copyWith(
                                    color: Colors.white),
                              ),
                              const TextSpan(
                                  text: 'rules of our company',
                                  style: smallTextStyleAuthScreens),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: media.height * .10,
                      ),
                      Container(
                        // color: Colors.red,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SocialButton(
                              icon: IconConstance.iGoogleIcon,
                              onPressed: () async {
                                bloc.add(const LoginByGoogleEvent());
                              },
                            ),
                            SocialButton(
                              icon: IconConstance.iTwitterIcon,
                              onPressed: () {
                                bloc.add(const LoginByTwitterEvent());
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: media.height * .16),
                      InkWell(
                        onTap: () {
                          AnimationRoute.slideRoute(context,
                              pageRoute:
                                  const RegisterByEmailAndPasswordScreen(),
                              rigthToLeft: true);
                        },
                        child: Container(
                          // color: Colors.blue,
                          alignment: Alignment.center,
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: smallStyleSize.copyWith(fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Sign up',
                                    style: smallTextStyleAuthScreens.copyWith(
                                        color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(
        //     vertical: media.height * .13,
        //   ),
        //   child: Column(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       Container(
        //         // color: Colors.red,
        //         alignment: Alignment.center,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceAround,
        //           children: [
        //             socialButtons(icon: iGoogleIcon),
        //             socialButtons(icon: iPhoneIcon),
        //             socialButtons(icon: iTwitterIcon),
        //           ],
        //         ),
        //       ),
        // Container(
        //   color: Colors.blue,
        //   alignment: Alignment.center,
        //   child: RichText(
        //     text: TextSpan(
        //       text: "Don't have an account? ",
        //       style: smallStyleSize.copyWith(fontSize: 15),
        //       children: <TextSpan>[
        //         TextSpan(
        //             text: 'Sign up',
        //             style: smallTextStyleAuthScreens.copyWith(
        //                 color: Colors.white)),
        //       ],
        //     ),
        //   ),
        // ),
        //     ],
        //   ),
        // ),
      ],
    ));
  }
}
