import 'package:get/get_navigation/get_navigation.dart';

import 'ar.dart';
import 'en.dart';

class MyLocaliaizatoin extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {"ar": ar, "en": en};
}
