import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => SizedBox(height: 4),
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              elevation: 0,
              minimumSize: Size(double.infinity, 80),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: bombay))),
          child: Icon(
            IconData(int.parse(icon.iconCode),
                fontPackage: CupertinoIcons.iconFontPackage,
                fontFamily: icon.iconFont,
                matchTextDirection: true),
            color: Colors.indigo,
          ),
          // child: Container(
          //   width: double.infinity,
          //   height: 80,
          //   decoration: BoxDecoration(
          //       color: Colors.white,
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(
          //         color: silver,
          //       )),
          //   child: Icon(IconData(int.parse(icon.iconCode),
          //       fontPackage: CupertinoIcons.iconFontPackage,
          //       fontFamily: icon.iconFont,
          //       matchTextDirection: true)),
          // ),
        ),
        Text(
          icon.iconName,
          style: body,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
