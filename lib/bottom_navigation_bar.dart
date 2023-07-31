import 'package:flutter/material.dart';

import 'core/text_styles/text_style.dart';
import 'core/utils/app_constance/color_constance.dart';
import 'pages/home_screen/screens/home_screen.dart';
import 'pages/search/screens/search_home_screen.dart';

class BottomNavigationBarScreens extends StatefulWidget {
  const BottomNavigationBarScreens({super.key});

  @override
  State<BottomNavigationBarScreens> createState() =>
      _BottomNavigationBarScreensState();
}

class _BottomNavigationBarScreensState
    extends State<BottomNavigationBarScreens> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) {
          currentIndex = value;
          setState(() {});
        },
        children: const [
          HomeScreen(),
          SearchHomeScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 49, 49, 52),
        currentIndex: currentIndex,
        onTap: (value) {
          pageController.animateToPage(value,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear);
        },
        selectedLabelStyle: smallStyleSize.copyWith(fontSize: 12),
        selectedItemColor: ColorConstance.cDefaultColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.remove_from_queue_outlined),
            label: 'Movie',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
