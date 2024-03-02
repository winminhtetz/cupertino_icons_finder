import 'package:flutter/material.dart';

class RactIconBtn extends StatelessWidget {
  const RactIconBtn({
    super.key,
    this.iconColor,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final Color? iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 20, color: iconColor),
      style: ButtonStyle(
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: MaterialStatePropertyAll(EdgeInsets.zero),
      ),
    );
  }
}
