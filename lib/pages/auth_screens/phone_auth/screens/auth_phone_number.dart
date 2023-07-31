// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/text_styles/text_style.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/cutom_text_field/custom_text_filed.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/snak_bar.dart';
import '../../../../core/services/service_get_it.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/widgets/custom_navigation.dart';
import '../../../../core/widgets/cutom_text_field/custom_format.dart';

import '../../../login_screens/screens/login_screen.dart';
import '../controllers/bloc/phone_auth_bloc.dart';
import 'verfication_screen.dart';

class AuthPhoneNumberScreen extends StatelessWidget {
  bool? isForgotPassword = false;

  AuthPhoneNumberScreen({
    Key? key,
    this.isForgotPassword,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            AnimationRoute.fadeRoutePushAndRemoveUntil(
              context,
              pageRoute: const LoginScreen(),
            );
          },
          icon: Image.asset(
            IconConstance.iBackIcon,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          AnimationRoute.fadeRoutePushAndRemoveUntil(
            context,
            pageRoute: const LoginScreen(),
          );
          return true;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: media.height * .05,
            horizontal: media.width * .06,
          ),
          child: BlocProvider(
            create: (context) => sl<PhoneAuthBloc>(),
            child: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
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
                  Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      AnimationRoute.slideRoute(
                        context,
                        pageRoute: VerificationScreen(
                          number: state.phoneController!.text,
                        ),
                      );
                    },
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
              },
              builder: (context, state) {
                return Column(children: [
                  Text(
                    isForgotPassword == true
                        ? "Forgot Password ? "
                        : "e-mail Authentication ",
                    style: largeStyleSize.copyWith(
                        color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    isForgotPassword == true
                        ? "Enter your phone number indicated upon registration ,and we will send you Verification code to change  "
                        : "Enter your phone number ,and we will send you Verification code ",
                    style: smallTextStyleAuthScreens,
                  ),
                  const SizedBox(height: 30),
                  CustomTextField(
                    hinText: "+2011",
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    labelText: "Phone Number",
                    inputFormatters: [
                      // FilteringTextInputFormatter.allow(RegExp("[0-9]' '")),
                      MaskedTextInputFormatter(
                        mask: "xxx xxx xxxx",
                        separator: " ",
                      ),
                    ],
                    controller: state.phoneController,
                  ),
                  const SizedBox(height: 30),
                  customButton(
                    text: "Send",
                    width: media.width,
                    onPressed: () {
                      AnimationRoute.slideRoute(
                        context,
                        pageRoute: VerificationScreen(
                          number:
                              "+20${state.phoneController!.text.toString()}",
                        ),
                        leftToRight: true,
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'By clicking the "Log in" button , you accept',
                        style: smallTextStyleAuthScreens.copyWith(fontSize: 15),
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
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
