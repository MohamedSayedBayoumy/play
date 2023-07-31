// ignore_for_file: deprecated_member_use, avoid_init_to_null, unnecessary_null_comparison, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../text_styles/text_style.dart';
import '../../utils/app_constance/color_constance.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final bool suffixIcon;
  final double? height;
  final double? width;
  final int? length;
  final int? maxLength;
  final int? minLength;
  final String? labelText;
  final String? hinText;
  final bool? fill;
  bool obscureText = false;
  final Color? fillColor;
  final Color? borderColor;
  final Color? labelColor;
  final InputBorder? styleBorder;
  final String? Function(String?)? valid;
  final String? Function(String?)? onChange;
  final String? Function(String?)? onFieldSubmitted;
  final void Function()? onTap;
  final bool? enabled;
  final TextInputType? keyboardType;
  final dynamic enabledCurveBorder;
  final TextInputAction? textInputAction;
  final String? errorText;
  final void Function()? onPressedSuffixIcon;
  final FloatingLabelBehavior? needLabel;
  final Color? enabledColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextAlign? textAlign;
  final EdgeInsetsGeometry? contentPadding;

  CustomTextField(
      {Key? key,
      required this.controller,
      this.inputFormatters,
      this.contentPadding = null,
      this.textAlign = TextAlign.start,
      this.initialValue,
      this.obscureText = false,
      this.enabledColor,
      this.needLabel,
      this.prefixIcon,
      this.textInputAction = TextInputAction.next,
      this.suffixIcon = false,
      this.onPressedSuffixIcon,
      this.keyboardType,
      this.enabledCurveBorder,
      this.labelColor,
      this.onChange,
      this.onTap,
      this.maxLength,
      this.onFieldSubmitted,
      required this.hinText,
      this.minLength,
      this.fill,
      this.fillColor,
      this.valid,
      this.labelText,
      this.enabled,
      this.length,
      this.height,
      this.styleBorder,
      this.width,
      this.borderColor,
      this.errorText})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: const Color(0xff2c2c2e),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: SizedBox(
            width: widget.width,
            child: TextFormField(
              
              toolbarOptions: const ToolbarOptions(
                copy: true,
                cut: true,
                paste: false,
                selectAll: false,
              ),
              style: defaultStyleSize.copyWith(
                  color: Theme.of(context).primaryColor),
              obscureText:
                  widget.obscureText == null || widget.obscureText == false
                      ? false
                      : true,
              textInputAction: widget.textInputAction,
              textAlign: widget.textAlign!,
              keyboardType: widget.keyboardType,
              onChanged: widget.onChange,
              onFieldSubmitted: widget.onFieldSubmitted,
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              enabled: widget.enabled,
              validator: widget.valid,
              controller: widget.controller,
              maxLines: widget.maxLength,
              minLines: widget.minLength,
              maxLength: widget.length,
              inputFormatters: widget.inputFormatters,
              maxLengthEnforcement:
                  MaxLengthEnforcement.truncateAfterCompositionEnds,
              cursorColor: ColorConstance.cDefaultColor,
              decoration: InputDecoration(
                  errorText: widget.errorText,
                  suffixIcon: widget.suffixIcon == false
                      ? null
                      : IconButton(
                          onPressed: () {
                            widget.obscureText = !widget.obscureText;
                            setState(() {});
                          },
                          icon: Icon(
                              widget.obscureText == true
                                  ? Icons.visibility
                                  : Icons.visibility_off_sharp,
                              color: widget.obscureText == true
                                  ? ColorConstance.cDefaultColor
                                  : ColorConstance.cDefaultColor
                                      .withOpacity(.45))),
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: widget.contentPadding == null
                      ? null
                      : EdgeInsets.symmetric(
                          horizontal: media.width * .03,
                          // vertical: media.height * .02,
                        ),
                  labelText: widget.labelText,
                  labelStyle: smallStyleSize.copyWith(
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 161, 161, 161),
                  ),
                  hintText: widget.hinText,
                  hintStyle: smallStyleSize.copyWith(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 87, 87, 87),
                  ),
                  prefixIcon: widget.prefixIcon == null
                      ? null
                      : Icon(widget.prefixIcon,
                          color: Theme.of(context).primaryColor),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none),
            )));
  }
}
