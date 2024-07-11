import 'dart:math';
import 'package:pixel_infotainment/musicplayer/common/page_general_class.dart';

class AudioPlayerManager {
  List<Mp3File> shuffleWithRandomNumber(List<Mp3File> list) {
    final random = Random();
    final shuffledList = List<Mp3File>.from(list);
    for (int i = shuffledList.length - 1; i > 0; i--) {
      int j = random.nextInt(i + 1);
      Mp3File temp = shuffledList[i];
      shuffledList[i] = shuffledList[j];
      shuffledList[j] = temp;
    }
    return shuffledList;
  }

  RepeatMode toggleRepeatMode(RepeatMode currentMode) {
    switch (currentMode) {
      case RepeatMode.none:
        return RepeatMode.repeatOne;
      case RepeatMode.repeatOne:
        return RepeatMode.repeatAll;
      case RepeatMode.repeatAll:
        return RepeatMode.repeatdisabled;
      case RepeatMode.repeatdisabled:
        return RepeatMode.none;
    }
  }
}
