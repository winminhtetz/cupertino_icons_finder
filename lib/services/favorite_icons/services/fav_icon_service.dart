import 'package:ios_icon_finder/services/favorite_icons/models/fav_icon_model.dart';
import 'package:ios_icon_finder/services/favorite_icons/repostiory/fav_icon_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fav_icon_service.g.dart';

@riverpod
class FavIconsService extends _$FavIconsService {
  FavIconRepo repo = FavIconRepo();

  @override
  List<FavIcon> build() {
    return repo.getFavIcons();
  }

  void addToFavorite(FavIcon icon) {
    state = repo.addToFavorite(icon);
  }

  void deleteFavorite(int iconCode) {
    state = repo.removeFromFavorite(iconCode);
  }
}
