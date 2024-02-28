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
    bool isFav = favIcons.where((e) => _checkEqual(e)).isNotEmpty;
    final reactIcon = isFav ? CupertinoIcons.heart_fill : CupertinoIcons.heart;

    return AnimatedItemAction(
      backgroundColor: Colors.white,
      duration: Duration(milliseconds: 400),
      startActions: [
        RactIconBtn(onPressed: () => onCopy(context), icon: CupertinoIcons.doc)
      ],
      endActions: [
        RactIconBtn(
          icon: reactIcon,
          iconColor: isFav ? Colors.red : null,
          onPressed: () => onReactChanged(context, ref, isFav),
        ),
      ],
      builder: (_, __) => Padding(
        padding: EdgeInsets.all(14),
        child: SeparatedRow(
          separatorBuilder: () => SizedBox(width: 8),
          children: [
            IconUI(icon: icon),
            IconInfo(icon: icon),
          ],
        ),
      ),
    );
  }

  bool _checkEqual(FavIcon e) {
    int code = int.parse(icon.iconCode);
    bool conditionOne = e.iconCode == code;
    bool conditionTwo = e.iconName.contains(icon.iconName);
    return conditionOne && conditionTwo;
  }

  Future<void> onCopy(BuildContext context) async {
    var iconName = icon.iconName;
    await Clipboard.setData(ClipboardData(text: iconName));
    if (!context.mounted) return;
    context.showSnackBar("Copied \"$iconName\" to clipboard 🥳!");
  }

  void onReactChanged(context, ref, isFav) {
    if (isFav) return onRemovedFav(context, ref);
    onFavorite(context, ref);
  }

  void onFavorite(BuildContext context, WidgetRef ref) {
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
