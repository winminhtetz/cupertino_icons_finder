import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/widgets/app_title.dart';
import 'package:ios_icon_finder/src/pages/mobile/home/widgets/icon_search_bar.dart';

class TitleComponent extends StatelessWidget {
  const TitleComponent({
    super.key,
    required this.onSearch,
    required this.onShowFav,
  });

  final ValueChanged<String> onSearch;
  final VoidCallback onShowFav;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => SizedBox(height: 8),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(onShowFav: onShowFav),
        IconSearchBar(onChanged: onSearch),
        SizedBox(height: 1),
      ],
    );
  }
}
