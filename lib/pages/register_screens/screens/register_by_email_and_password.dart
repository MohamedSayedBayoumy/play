// ignore_for_file: body_might_complete_normally_nullable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/functions/alert_dialog.dart';
import '../../../core/functions/snak_bar.dart';
import '../../../core/services/service_get_it.dart';
import '../../../core/text_styles/text_style.dart';
import '../../../core/utils/app_constance/color_constance.dart';
import '../../../core/utils/app_constance/icon_constance.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_navigation.dart';
import '../../../core/widgets/custom_social_button.dart';
import '../../../core/widgets/cutom_text_field/custom_format.dart';
import '../../../core/widgets/cutom_text_field/custom_text_filed.dart';
import '../../auth_screens/phone_auth/screens/auth_phone_number.dart';
import '../../auth_screens/phone_auth/screens/verfication_screen.dart';
import '../controllers/register_bloc_bloc.dart';
import '../controllers/register_bloc_event.dart';
import '../controllers/register_bloc_state.dart';

class RegisterByEmailAndPasswordScreen extends StatelessWidget {
  const RegisterByEmailAndPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            IconConstance.iBackIcon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: media.width * .05, vertical: 0),
            child: BlocProvider<RegisterBloc>(
              create: (context) => sl<RegisterBloc>(),
              child: BlocConsumer<RegisterBloc, RegisterBlocState>(
                listener: (context, state) {
                  if (state.isLoading == true) {
                    showMyDialog(
                      context,
                      barrierDismissible: false,
                      needBackgroundColor: false,
                      content: Center(
                        child: CircularProgressIndicator(
                          valueColor: const AlwaysStoppedAnimation(Colors.red),
                          backgroundColor: Theme.of(context).primaryColor,
                          color: ColorConstance.cDefaultColor,
                        ),
                      ),
                    );
                  } else if (state.isSucces == true &&
                      state.phoneNumberController!.text.isNotEmpty) {
                    Navigator.pop(context);

                    snackBar(
                      context,
                      message: "Succesfully",
                      isSuccess: true,
                    );
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Navigator.pop(context);

                        AnimationRoute.slideRoute(
                          context,
                          pageRoute: VerificationScreen(
                            number: "+20${state.phoneNumberController!.text}",
                          ),
                        );
                      },
                    );
                  } else if (state.isSucces == true &&
                      state.phoneNumberController!.text.isEmpty) {
                    Navigator.pop(context);

                    snackBar(
                      context,
                      message: "Succesfully",
                      isSuccess: true,
                    );
                    Future.delayed(
                      const Duration(seconds: 3),
                      () {
                        Navigator.pop(context);

                        AnimationRoute.slideRoute(
                          context,
                          pageRoute: AuthPhoneNumberScreen(),
                        );
                      },
                    );
                  } else if (state.isFaliure == true) {
                    Navigator.pop(context);

                    showMyDialog(
                      context,
                      title: "Error",
                      subTitle: state.errorMessage,
                      onPressed: () {},
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  final bloc = BlocProvider.of<RegisterBloc>(context);
                  return Form(
                    key: state.registerFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Sign Up",
                          style: largeStyleSize.copyWith(
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          hinText: "username",
                          labelText: "Nickname",
                          controller: state.userNameController,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          hinText: "example@example.com",
                          labelText: "E-mail",
                          valid: (p0) => state.errorEmail(val: p0.toString()),
                          controller: state.emailController,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          valid: (p0) => state.validation(val: p0),
                          hinText: "+20",
                          labelText: "Phone Number",
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskedTextInputFormatter(
                                mask: "xxx xxx xxxx", separator: " "),
                          ],
                          controller: state.phoneNumberController,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          hinText: "abc*****",
                          labelText: "Password",
                          valid: (p0) => state.validation(val: p0),
                          suffixIcon: true,
                          maxLength: 1,
                          controller: state.passWordController,
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          hinText: "Confirm Password",
                          labelText: "Confirm Password",
                          valid: (p0) => state.validation(val: p0),
                          textInputAction: TextInputAction.done,
                          suffixIcon: true,
                          maxLength: 1,
                          controller: state.confirmpassWordController,
                        ),
                        const SizedBox(height: 40),
                        customButton(
                          text: "Next",
                          width: media.width,
                          onPressed: () {
                            bloc.add(RegisterByAuthenticationEvent());
                          },
                        ),
                        const SizedBox(height: 8),
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
                                onPressed: () {
                                  bloc.add(RegisterByGoogleEvent());
                                },
                              ),
                              SocialButton(
                                icon: IconConstance.iTwitterIcon,
                                onPressed: () {
                                  bloc.add(RegisterByTwitterEvent());
                                },
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(height: media.height * .16),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Future login() async {}
}
