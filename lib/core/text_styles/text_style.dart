import 'package:flutter/material.dart';

import '../utils/app_constance/font_constance.dart';
import '../utils/app_constance/size_constance.dart';

const defaultStyleSize = TextStyle(
  fontSize: SizeConstance.defaultFontSize,
  fontFamily: FontConstance.fDefaultFontFamily,
  fontWeight: FontWeight.w500,
);

const smallStyleSize = TextStyle(
  fontSize: SizeConstance.smallFontSize,
  fontFamily: FontConstance.fDefaultFontFamily,
  fontWeight: FontWeight.w500,
  color: Color.fromARGB(255, 117, 117, 117),
);

const largeStyleSize = TextStyle(
  fontSize: SizeConstance.largeFontSize,
  fontFamily:FontConstance. fDefaultFontFamily,
  fontWeight: FontWeight.w600,
);

const buttonTextStyleSize = TextStyle(
  fontSize: SizeConstance.smallFontSize,
  fontFamily: FontConstance.fDefaultFontFamily,
  fontWeight: FontWeight.w600,
);

const smallTextStyleAuthScreens = TextStyle(
  fontFamily: FontConstance.fDefaultFontFamily,
  fontSize: 15,
  color: Color.fromARGB(255, 123, 123, 123),
  fontWeight: FontWeight.w500,
);

const homeScreenTextStyleAuthScreens = TextStyle(
  fontFamily: FontConstance.fDefaultFontFamily,
  fontSize: 15,
  color: Color.fromARGB(255, 123, 123, 123),
  fontWeight: FontWeight.normal,
) ; 
