import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';

class IconUI extends StatelessWidget {
  const IconUI({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: porcelain,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        IconData(
          int.parse(icon.iconCode),
          matchTextDirection: true,
          fontFamily: icon.iconFont,
          fontPackage: CupertinoIcons.iconFontPackage,
        ),
        color: Colors.black,
      ),
    );
  }
}
