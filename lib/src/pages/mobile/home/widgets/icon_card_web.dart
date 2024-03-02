import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/widgets/icon_card/icon_info.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/widgets/icon_card/icon_ui.dart';

class IconCardWeb extends StatelessWidget {
  const IconCardWeb({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: bombay),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          IconUI(icon: icon),
          SizedBox(height: 8),
          IconInfo(icon: icon),
        ],
      ),
    );
  }
}
