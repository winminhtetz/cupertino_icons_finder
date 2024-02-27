// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import 'package:ios_icon_finder/services/ios%20_icons/models/ios_icon_model.dart';

part 'fav_icon_model.g.dart';

@HiveType(typeId: 1)
class FavIcon extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final IosIcon icon;

  FavIcon({required this.icon}) : id = const Uuid().v4();

  FavIcon copyWith({
    String? id,
    IosIcon? icon,
  }) {
    return FavIcon(
      icon: icon ?? this.icon,
    );
  }
}
