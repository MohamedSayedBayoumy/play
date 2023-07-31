// ignore_for_file: file_names

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

Widget fadeDownTOUp({required Widget child}) => FadeInDown(
    duration: const Duration(milliseconds: 1400),
    delay: const Duration(milliseconds: 200),
    child: child);

class FadeInUpWidget extends StatelessWidget {
  final Widget? child;
  const FadeInUpWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
        duration: const Duration(milliseconds: 1400),
        delay: const Duration(milliseconds: 200),
        child: child!);
  }
}

class FadeElasticIn extends StatelessWidget {
  final Widget? child;
  const FadeElasticIn({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
        duration: const Duration(milliseconds: 1400),
        delay: const Duration(milliseconds: 200),
        child: child!);
  }
}

Widget fadeOutLeft({required Widget child}) => FadeInLeft(
    duration: const Duration(milliseconds: 1000),
    delay: const Duration(milliseconds: 100),
    child: child);
