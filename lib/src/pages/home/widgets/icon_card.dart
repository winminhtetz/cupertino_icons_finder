import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';

class IconCard extends StatelessWidget {
  const IconCard({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffECEEF0)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SeparatedRow(
        separatorBuilder: () => SizedBox(height: 4),
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xffECEEF0),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              IconData(int.parse(icon.iconCode),
                  fontPackage: CupertinoIcons.iconFontPackage,
                  fontFamily: icon.iconFont,
                  matchTextDirection: true),
              color: Colors.indigo,
            ),
          )
        ],
      ),
    );
  }
}
