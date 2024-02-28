import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/global/constant/app_text.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.onShowFav});

  final VoidCallback onShowFav;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(appName, style: header),
            Text(madeWithLove, style: body.copyWith(color: silver))
          ],
        ),
        IconButton(
          onPressed: onShowFav,
          icon: Icon(CupertinoIcons.list_bullet),
        ),
      ],
    );
  }
}
