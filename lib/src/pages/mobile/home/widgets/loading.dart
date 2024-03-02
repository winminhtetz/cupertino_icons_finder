import 'package:flutter/material.dart';

class LoadingUI extends StatelessWidget {
  const LoadingUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
