import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';

class RactIconBtn extends StatelessWidget {
  const RactIconBtn({super.key, required this.onPressed, required this.icon});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 14),
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: porcelain),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
