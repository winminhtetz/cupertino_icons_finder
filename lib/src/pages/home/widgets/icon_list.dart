import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card.dart';

class IconList extends StatelessWidget {
  const IconList({super.key, required this.icons, required this.onRefresh});

  final List<IosIcon> icons;
  final Future<void> onRefresh;

  @override
  Widget build(BuildContext context) {
    return CustomMaterialIndicator(
      onRefresh: () => onRefresh,
      indicatorBuilder: (context, controller) {
        return Icon(
          CupertinoIcons.refresh,
          color: Colors.indigo,
          size: 20,
        );
      },
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: icons.length,
        padding: EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          IosIcon icon = icons[index];
          return IconCard(icon: icon);
        },
      ),
    );
  }
}
