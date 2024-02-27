import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/global/util/show_snackbar.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/ract_icon_btn.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_info.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_ui.dart';

class IconCard extends StatefulWidget {
  const IconCard({super.key, required this.icon});

  final IosIcon icon;

  @override
  State<IconCard> createState() => _IconCardState();
}

class _IconCardState extends State<IconCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: porcelain),
        borderRadius: BorderRadius.circular(8),
      ),
      child: SeparatedRow(
        separatorBuilder: () => SizedBox(width: 8),
        children: [
          IconUI(icon: widget.icon),
          IconInfo(icon: widget.icon),
          RactIconBtn(
            onPressed: () => onCopy(context),
            icon: CupertinoIcons.doc,
          ),
          RactIconBtn(
            onPressed: () => onFavorite(context),
            icon: CupertinoIcons.heart,
          ),
        ],
      ),
    );
  }

  Future<void> onCopy(BuildContext context) async {
    var iconName = widget.icon.iconName;
    await Clipboard.setData(ClipboardData(text: iconName));
    if (!context.mounted) return;
    context.showSnackBar("Copied \"$iconName\" to clipboard 🥳!");
  }

  onFavorite(BuildContext context) {}
}
