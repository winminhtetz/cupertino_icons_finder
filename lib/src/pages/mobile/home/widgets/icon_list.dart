import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/services/ios%20_icons/services/ios_icon_service.dart';
import 'package:ios_icon_finder/src/global/extensions/responsive_extension.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/widgets/icon_card/icon_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class IconList extends ConsumerWidget {
  const IconList({super.key, required this.icons});

  final List<IosIcon> icons;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width.isMobile;
    int columnsCount = (size.width / 200).floor();
    double aspectRatio = size.width / (columnsCount * 100);

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: LiquidPullToRefresh(
        height: 60,
        color: coconut,
        animSpeedFactor: 2,
        backgroundColor: mineShaft,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 800,
        onRefresh: () => ref.refresh(iosIconServiceProvider.future),
        child: isMobile
            ? ListView.separated(
                separatorBuilder: (_, __) => SizedBox(height: 8),
                shrinkWrap: true,
                itemCount: icons.length,
                padding: EdgeInsets.symmetric(vertical: 10),
                itemBuilder: (context, index) {
                  IosIcon icon = icons[index];
                  return IconCard(icon: icon);
                },
              )
            : GridView.builder(
                itemCount: icons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: columnsCount,
                  childAspectRatio: aspectRatio,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  IosIcon icon = icons[index];
                  return IconCard(
                    icon: icon,
                    rightToActions: true,
                  );
                },
              ),
      ),
    );
  }
}
