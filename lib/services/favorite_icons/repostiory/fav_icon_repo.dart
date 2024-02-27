import 'package:hive_flutter/adapters.dart';
import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';

class FavIconRepo {
  final Box<FavIcon> _hive = Hive.box('favorite_icons');

  FavIconRepo();

  List<FavIcon> getFavIcons() {
    return _hive.values.toList();
  }

  List<FavIcon> addToFavorite(FavIcon icon) {
    _hive.add(icon);
    return _hive.values.toList();
  }

  List<FavIcon> removeFromFavorite(int iconCode) {
    List<FavIcon> icons = _hive.values.toList();
    _hive.deleteAt(icons.indexWhere((e) => e.iconCode == iconCode));
    return _hive.values.toList();
  }
}
