import 'package:pixel_infotainment/musicplayer/common/page_general_class.dart';

class FvouriteManager {
  List<Mp3File> favourite = [];

  void addFavourite(Mp3File song) {
    favourite.add(song);
  }

  void removeFavourite(Mp3File song) {
    favourite.remove(song);
  }

  bool isFavourite(Mp3File song) {
    return favourite.contains(song);
  }

  int updateFavouritesong(Mp3File song) {
    if (isFavourite(song)) {
      removeFavourite(song);
      return 0;
    } else {
      addFavourite(song);
      return 1;
    }
  }
}
