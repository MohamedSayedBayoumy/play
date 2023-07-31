import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bottom_navigation_bar.dart';
import 'core/fcm_firebase/fcm_notification.dart';

import 'core/services/service_get_it.dart';
import 'core/theme/theme_data.dart';
import 'firebase_options.dart';

import 'pages/login_screens/screens/login_screen.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  FirebaseFcm.onFcmMessage();
  FirebaseFcm.getTokenMessage();
  FirebaseFcm.onFcmMessageOpenApp();
  FirebaseFcm.onFcmMessageOnBackGround();

  ServicesLocator.service();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
  // runApp(
  //   DevicePreview(
  //     builder: (context) => const MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: CustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      locale: const Locale("en"),
      builder: DevicePreview.appBuilder,
      theme: ligthThemeData,
      darkTheme: darakThemeData,
      themeMode: ThemeMode.dark,
      home: const Condition(),
    );
  }
}

class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class Condition extends StatelessWidget {
  const Condition({super.key});

  @override
  Widget build(BuildContext context) {
    if (prefs.getString("InterstingMovie") == null) {
      return const LoginScreen();
    } else {
      return const BottomNavigationBarScreens();
    }
  }
}
