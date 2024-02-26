import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('CupertinoIcons Finder', style: header),
        Text(
          'Please search the name of icon',
          style: body.copyWith(color: silver),
        )
      ],
    );
  }
}
