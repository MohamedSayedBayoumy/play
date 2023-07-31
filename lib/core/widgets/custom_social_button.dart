import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  final String icon;
  final void Function()? onPressed;
  const SocialButton({required this.icon, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black38,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Image.asset(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}
