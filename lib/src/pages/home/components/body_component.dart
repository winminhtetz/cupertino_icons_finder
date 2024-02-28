import 'package:flutter/cupertino.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/constant/app_text.dart';
import 'package:ios_icon_finder/src/global/widgets/empty_ui.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_list.dart';

class BodyComponent extends StatelessWidget {
  const BodyComponent({super.key, required this.icons});

  final List<IosIcon> icons;

  @override
  Widget build(BuildContext context) {
    if (icons.isNotEmpty) return Expanded(child: IconList(icons: icons));
    return Expanded(
      child: EmptyUI(icon: CupertinoIcons.search, message: noMatchFound),
    );
  }
}
