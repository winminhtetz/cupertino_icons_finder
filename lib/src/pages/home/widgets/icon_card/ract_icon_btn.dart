import 'package:flutter/material.dart';

class RactIconBtn extends StatelessWidget {
  const RactIconBtn({super.key, required this.onPressed, required this.icon});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
    );
  }
}
