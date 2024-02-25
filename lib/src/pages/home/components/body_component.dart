import 'package:flutter/material.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_list.dart';

class BodyComponent extends StatelessWidget {
  const BodyComponent({super.key, required this.icons, required this.onRefresh});

  final List<IosIcon> icons;
  final Future<void> onRefresh;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: IconList(
      icons: icons,
      onRefresh: onRefresh,
    ));
    // return switch (iosIcons) {
    //   AsyncData(:final value) => Expanded(child: IconList(icons: value)),
    //   AsyncError(:final error) => Text('$error'),
    //   _ => CircularProgressIndicator(),
    // };
  }
}
