import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CupertinoIcons Finder', style: header),
            Text(
              'Made with ❤️ by BadazzHarry',
              style: body.copyWith(color: silver),
            )
          ],
        ),
        IconButton(onPressed: onRefresh, icon: Icon(CupertinoIcons.refresh)),
      ],
    );
  }
}
