import 'package:flutter/material.dart';
import 'package:pixel_infotainment/commonapi/constant.dart';
import 'package:pixel_infotainment/musicplayer/common/page_common_controls_ui.dart';
import 'package:pixel_infotainment/musicplayer/common/page_general_class.dart';
import 'package:pixel_infotainment/commonapi/commonapi.dart';

class UpdatePreviousNextButton extends StatelessWidget {
  final Widget? songAlbumArt;
  final Function() onTapFunction;
  final String svgFile;

  const UpdatePreviousNextButton({
    required this.songAlbumArt,
    required this.onTapFunction,
    required this.svgFile,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: albumPreviousNextHeight,
          width: albumPreviousNextWidth,
          child: songAlbumArt,
        ),
        getGestureDetectorWidget(onTapFunction, svgFile,
            getMusicPlayerImageFolderName(), svgImageWidth, svgImageWidth),
      ],
    );
  }
}

class UpdateActionButton extends StatelessWidget {
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback onFavourite;
  final VoidCallback onRepeat;
  final VoidCallback onShuffle;
  final VoidCallback onForwad;
  final VoidCallback onBackward;

  const UpdateActionButton(
      {super.key,
      required this.onPlay,
      required this.onStop,
      required this.onRepeat,
      required this.onFavourite,
      required this.onShuffle,
      required this.onForwad,
      required this.onBackward});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 300,
      top: actionButtonTop,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Button Fast Backward
          GestureDetector(
            onLongPress: longPressRecognizerBackward.onLongPress,
            onLongPressEnd: longPressRecognizerBackward.onLongPressEnd,
            onTap: () {
              onBackward();
            },
            child: getSVGPictureAsset(skipBackwardImages[skipBackwardIndex],
                getMusicPlayerImageFolderName(), svgImageWidth, svgImageHeight),
          ),
          const SizedBox(
            width: 80,
          ),
          // Button Favourite
          getGestureDetectorWidget(onFavourite, favImages[favouriteIndex],
              getMusicPlayerImageFolderName(), svgImageWidth, svgImageHeight),
          const SizedBox(
            width: 80,
          ),
          // Button Repeat
          getGestureDetectorWidget(onRepeat, repeatImages[repeatMode.index],
              getMusicPlayerImageFolderName(), svgImageWidth, svgImageHeight),
          const SizedBox(
            width: 80,
          ),
          // Pause and Play Button
          getGestureDetectorWidget(
              onPlay,
              isSongPlaying
                  ? "p_icon_48X48_pause.svg"
                  : "p_icon_48X48_play.svg",
              getMusicPlayerImageFolderName(),
              svgImageWidth,
              svgImageHeight),
          const SizedBox(
            width: 80,
          ),
          // Button Shuffle
          getGestureDetectorWidget(
              onShuffle,
              isShuffled ? shuffleImages[1] : shuffleImages[0],
              getMusicPlayerImageFolderName(),
              svgImageWidth,
              svgImageHeight),
          const SizedBox(
            width: 80,
          ),

          // Button Stop
          getGestureDetectorWidget(onStop, stopImages[stopIndex],
              getMusicPlayerImageFolderName(), svgImageWidth, svgImageHeight),
          const SizedBox(
            width: 80,
          ),
          // Button Fast Farward
          GestureDetector(
            onLongPress: longPressRecognizerForward.onLongPress,
            onLongPressEnd: longPressRecognizerForward.onLongPressEnd,
            onTap: () {
              onForwad();
            },
            child: getSVGPictureAsset(skipForwardImages[skipForwardIndex],
                getMusicPlayerImageFolderName(), svgImageWidth, svgImageHeight),
          ),
        ],
      ),
    );
  }
}
