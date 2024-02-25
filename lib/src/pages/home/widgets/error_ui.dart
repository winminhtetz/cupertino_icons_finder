import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class ErrorUI extends StatelessWidget {
  const ErrorUI({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SeparatedColumn(
        separatorBuilder: () => SizedBox(height: 8),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('An Error occured!', style: body.copyWith(color: Colors.red)),
          TextButton(onPressed: onPressed, child: Text('Refresh'))
        ],
      ),
    );
  }
}
