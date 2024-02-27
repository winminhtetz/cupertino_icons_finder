import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/services/favorite_icons/services/fav_icon_service.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/src/global/widgets/empty_ui.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_card.dart';

class FavIconsPage extends ConsumerWidget {
  const FavIconsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favIcons = ref.watch(favIconsServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Icons'),
        centerTitle: true,
      ),
      body: favIcons.isEmpty
          ? EmptyUI(
              icon: CupertinoIcons.heart_slash,
              message: 'No Favorite Icons Found!',
            )
          : ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 8),
              shrinkWrap: true,
              itemCount: favIcons.length,
              padding: EdgeInsets.symmetric(vertical: 10),
              itemBuilder: (context, index) {
                FavIcon favIcon = favIcons[index];
                IosIcon icon = IosIcon(
                    iconName: favIcon.iconName,
                    iconCode: favIcon.iconCode.toString(),
                    iconFont: 'CupertinoIcons');

                return IconCard(icon: icon);
              },
            ),
    );
  }
}