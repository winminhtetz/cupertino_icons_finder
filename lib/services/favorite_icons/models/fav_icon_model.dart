// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'fav_icon_model.g.dart';

@HiveType(typeId: 1)
class FavIcon extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final int iconCode;
  @HiveField(2)
  final String iconName;

  FavIcon({
    required this.iconCode,
    required this.iconName,
  }) : id = const Uuid().v4();
}
