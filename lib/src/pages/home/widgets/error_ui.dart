import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class ErrorUI extends StatelessWidget {
  const ErrorUI({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SeparatedColumn(
          separatorBuilder: () => SizedBox(height: 8),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Unable to connect to the internet',
                style: body.copyWith(color: Colors.red)),
            Text(
                'Can\'t display the icons because your device isn\'t connected to the internet.',
                style: bodySmall.copyWith(color: Colors.black)),
            Align(
                alignment: Alignment.center,
                child: TextButton(onPressed: onPressed, child: Text('Refresh')))
          ],
        ),
      ),
    );
  }
}
