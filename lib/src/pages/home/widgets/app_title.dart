import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_icon_finder/services/favorite_icons/services/fav_icon_service.dart';
import 'package:ios_icon_finder/src/global/constant/app_text.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';
import 'package:badges/badges.dart' as badges;

class AppTitle extends ConsumerWidget {
  const AppTitle({super.key, required this.onShowFav});

  final VoidCallback onShowFav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = bodySmall.copyWith(color: Colors.white);
    final favIcons = ref.watch(favIconsServiceProvider);
    final count = favIcons.length;
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
        badges.Badge(
          badgeContent: Text('$count', style: style),
          position: badges.BadgePosition.custom(top: -2, end: -2),
          badgeStyle: badges.BadgeStyle(badgeColor: Colors.black),
          child: IconButton(
            onPressed: onShowFav,
            icon: Icon(CupertinoIcons.list_bullet),
          ),
        ),
      ],
    );
  }
}
