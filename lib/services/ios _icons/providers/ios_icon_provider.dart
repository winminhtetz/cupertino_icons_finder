import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';
import 'package:ios_icon_finder/services/ios%20_icons/services/ios_icon_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ios_icon_provider.g.dart';

@riverpod
List<IosIcon> iosIcon(IosIconRef ref, String q) {
  var query = q.toLowerCase();
  List<IosIcon> icons = [];
  final iosIcons = ref.watch(iosIconServiceProvider);

  iosIcons.whenData((value) => icons = value);

  if (query.isEmpty) {
    return icons;
  }

  icons = icons.where((e) => e.iconName.contains(query)).toList();
  return icons;
}
