import 'package:animated_item_action/animated_item_action.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/services/favorite_icons/services/fav_icon_service.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/util/show_snackbar.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/ract_icon_btn.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_info.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_ui.dart';

class IconCard extends ConsumerWidget {
  const IconCard({super.key, required this.icon});

  final IosIcon icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIcons = ref.watch(favIconsServiceProvider);
    bool isFavorited = favIcons
        .where((e) => e.iconCode == int.tryParse(icon.iconCode))
        .isNotEmpty;
    return AnimatedItemAction(
      duration: Duration(milliseconds: 400),
      backgroundColor: Colors.white,
      startActions: [
        RactIconBtn(
          onPressed: () => onCopy(context),
          icon: CupertinoIcons.doc,
        ),
      ],
      endActions: [
        RactIconBtn(
          onPressed: () {
            if (isFavorited) {
              onRemovedFav(context, ref);
              return;
            }
            onFavorite(context, ref);
          },
          icon: isFavorited ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
        ),
      ],
      builder: (context, isSelected) => Padding(
        padding: EdgeInsets.all(14),
        child: SeparatedRow(
          separatorBuilder: () => SizedBox(width: 8),
          children: [
            IconUI(icon: icon),
            IconInfo(icon: icon),
            // RactIconBtn(
            //   onPressed: () => onCopy(context),
            //   icon: CupertinoIcons.doc,
            // ),
            // RactIconBtn(
            //   onPressed: () {
            //     if (isFavorited) {
            //       onRemovedFav(context, ref);
            //       return;
            //     }
            //     onFavorite(context, ref);
            //   },
            //   icon:
            //       isFavorited ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> onCopy(BuildContext context) async {
    var iconName = icon.iconName;
    await Clipboard.setData(ClipboardData(text: iconName));
    if (!context.mounted) return;
    context.showSnackBar("Copied \"$iconName\" to clipboard 🥳!");
  }

  onFavorite(BuildContext context, WidgetRef ref) {
    var favIcon = FavIcon(
      iconName: icon.iconName,
      iconCode: int.parse(icon.iconCode),
    );
    ref.read(favIconsServiceProvider.notifier).addToFavorite(favIcon);
  }

  void onRemovedFav(BuildContext context, WidgetRef ref) {
    var iconCode = int.parse(icon.iconCode);
    ref.read(favIconsServiceProvider.notifier).deleteFavorite(iconCode);
  }
}
