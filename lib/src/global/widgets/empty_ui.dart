import 'package:flutter/cupertino.dart';

class EmptyUI extends StatelessWidget {
  const EmptyUI({super.key, required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          SizedBox(height: 8),
          Text(message),
        ],
      ),
    );
  }
}
