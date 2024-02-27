import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyUI extends StatelessWidget {
  const EmptyUI({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(height: 8),
          Text(message),
        ],
      ),
    );
  }
}
