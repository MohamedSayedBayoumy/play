// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';

import '../../../../../../../../core/text_styles/text_style.dart';

import '../../../../../../../../core/widgets/custom_button.dart';
import '../../../../../../../../core/widgets/cutom_text_field/custom_text_filed.dart';

import '../../../../../../../core/widgets/custom_navigation.dart';
import '../../../../../../../data/models/register_model.dart';
import '../../../../../../core/utils/app_constance/icon_constance.dart';
import '../../auth_screens/phone_auth/screens/verfication_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final RegisterModel? registerModel;

  ForgotPasswordScreen({this.registerModel, super.key});

  final TextEditingController x = TextEditingController();

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
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: media.height * .05,
          horizontal: media.width * .06,
        ),
        child: Column(children: [
          Text(
            "Forgot Password ? ",
            style:
                largeStyleSize.copyWith(color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Enter your phone number indicated upon registration ,and we will send you Verification code to change  ",
            style: smallTextStyleAuthScreens,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            hinText: "example@example.com",
            labelText: "E-mail",
            // valid: (p0) => state.validation(val: p0),
            controller: TextEditingController(),
          ),
          const SizedBox(height: 30),
          customButton(
            text: "send",
            width: media.width,
            onPressed: () async {
              AnimationRoute.slideRoute(
                context,
                pageRoute: VerificationScreen(
                  number: registerModel!.phoneNumber!,
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
                    style:
                        smallTextStyleAuthScreens.copyWith(color: Colors.white),
                  ),
                  const TextSpan(
                      text: 'rules of our company',
                      style: smallTextStyleAuthScreens),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
