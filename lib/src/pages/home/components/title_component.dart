import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/app_title.dart';
import 'package:ios_icon_finder/src/pages/home/widgets/icon_search_bar.dart';

class TitleComponent extends StatelessWidget {
  const TitleComponent({
    super.key,
    required this.onSearch,
    required this.onRefresh,
  });

  final ValueChanged<String> onSearch;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return SeparatedColumn(
      separatorBuilder: () => SizedBox(height: 8),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTitle(onRefresh: onRefresh),
        IconSearchBar(onChanged: onSearch),
      ],
    );
  }
}
