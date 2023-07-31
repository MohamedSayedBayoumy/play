// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../core/text_styles/text_style.dart';
import '../../../../core/functions/alert_dialog.dart';
import '../../../../core/functions/snak_bar.dart';
import '../../../../core/services/service_get_it.dart';
import '../../../../core/utils/app_constance/color_constance.dart';
import '../../../../core/utils/app_constance/icon_constance.dart';
import '../../../../core/widgets/custom_navigation.dart';
import '../../../home_screen/screens/home_screen.dart';
import '../../../login_screens/screens/login_screen.dart';
import '../controllers/bloc/phone_auth_bloc.dart';

class VerificationScreen extends StatefulWidget {
  final String? number;
  const VerificationScreen({
    Key? key,
    required this.number,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
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
      body: Padding(
        padding: EdgeInsets.only(
          top: media.height * .08,
          left: media.width * .08,
          right: media.width * .08,
        ),
        child: BlocProvider(
          create: (context) => sl<PhoneAuthBloc>()
            ..add(
              GetCodeAuthPhoneEvent(
                number: widget.number!,
                context: context,
              ),
            ),
          child: BlocConsumer<PhoneAuthBloc, PhoneAuthState>(
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
              } else if (state.isSuccess == true) {
                Navigator.pop(context);

                snackBar(
                  context,
                  message: "Succesfully",
                  isSuccess: true,
                );
                Future.delayed(
                  const Duration(seconds: 2),
                  () {
                    AnimationRoute.slideRoute(
                      context,
                      pageRoute: HomeScreen(),
                    );
                  },
                );
              } else if (state.isFailure == true) {
                Navigator.pop(context);

                showMyDialog(
                  context,
                  title: "Error",
                  subTitle: state.errorMessage,
                );
              } else {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              final bloc = BlocProvider.of<PhoneAuthBloc>(context);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Enter the code from your device",
                    style: largeStyleSize.copyWith(
                        fontSize: 40, color: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(height: media.height * .05),
                  Center(
                    child: Pinput(
                      androidSmsAutofillMethod:
                          AndroidSmsAutofillMethod.smsRetrieverApi,
                      length: 6,
                      animationCurve: Curves.easeInQuint,
                      onCompleted: (value) {
                        bloc.add(
                          SentVerificationCodeFromUser(
                            smsCode: value,
                            phoneNumber: widget.number,
                          ),
                        );
                      },
                      // الشكل الي هياخده بعد ما اكتب
                      defaultPinTheme: PinTheme(
                          height: media.height * .07,
                          width: media.width * .13,
                          textStyle: defaultStyleSize,
                          decoration: BoxDecoration(
                              color: ColorConstance.cDefaultColor,
                              borderRadius: BorderRadius.circular(8))),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      ],
                      keyboardType: TextInputType.number,
                      // اول حاجة هتظهر
                      followingPinTheme: PinTheme(
                          height: media.height * .07,
                          width: media.width * .13,
                          textStyle: defaultStyleSize,
                          decoration: BoxDecoration(
                              color: const Color(0xff2c2c2e),
                              borderRadius: BorderRadius.circular(8))),
                      focusedPinTheme: PinTheme(
                          height: media.height * .08,
                          width: media.width * .12,
                          textStyle: defaultStyleSize,
                          decoration: BoxDecoration(
                              color: ColorConstance.cDefaultColor,
                              borderRadius: BorderRadius.circular(8))),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
