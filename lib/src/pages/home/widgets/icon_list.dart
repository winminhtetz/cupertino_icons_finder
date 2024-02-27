import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/services/ios%20_icons/services/ios_icon_service.dart';
import 'package:ios_icon_finder/src/global/theme/app_color.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_card/icon_card.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class IconList extends ConsumerWidget {
  const IconList({super.key, required this.icons});

  final List<IosIcon> icons;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
      child: LiquidPullToRefresh(
        color: bombay,
        animSpeedFactor: 2,
        backgroundColor: silver,
        showChildOpacityTransition: false,
        springAnimationDurationInMilliseconds: 800,
        onRefresh: () => ref.refresh(iosIconServiceProvider.future),
        child: ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 8),
          shrinkWrap: true,
          itemCount: icons.length,
          padding: EdgeInsets.symmetric(vertical: 10),
          itemBuilder: (context, index) {
            IosIcon icon = icons[index];
            return IconCard(icon: icon);
          },
        ),
      ),
    );
  }
}
