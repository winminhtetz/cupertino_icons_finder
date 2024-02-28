import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/theme/text_style.dart';

class IconInfo extends StatelessWidget {
  const IconInfo({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            icon.iconName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: body.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(icon.iconFont, style: bodySmall),
        ],
      ),
    );
  }
}
