import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pixel_infotainment/fm/common/page_general_class.dart';
import 'package:pixel_infotainment/commonapi/constant.dart';
import 'package:pixel_infotainment/commonapi/commonapi.dart';

class ActionButtonPage extends StatefulWidget {
  double currentFrequencyValue;
  final VoidCallback onTapFreqIncrease;
  final VoidCallback onTapFreqDecrease;
  final VoidCallback onTapTrackerIncrease;
  final VoidCallback onTapTrackerDecrease;
  final VoidCallback onTapTrackerStop;
  final VoidCallback onTapSkipForward;
  final VoidCallback onTapSkipBackward;  
  final Function(bool) toggleTapFreq;    
  final List<String> increaseImages;
  final int forwardIndex;

  ActionButtonPage({
    required this.currentFrequencyValue,
    required this.onTapFreqIncrease,
    required this.onTapFreqDecrease,
    required this.onTapTrackerIncrease,
    required this.onTapTrackerDecrease,
    required this.onTapTrackerStop,
    required this.onTapSkipForward,
    required this.onTapSkipBackward,    
    required this.toggleTapFreq,    
    required this.increaseImages,
    required this.forwardIndex,
  });  

  @override
  _ActionButtonPageState createState() => _ActionButtonPageState();
}

class _ActionButtonPageState extends State<ActionButtonPage> {
  bool isHeartFilled = false;
  bool isFMPlaying = true;
  int backwardIndex = ButtonState.normal.index;
  int favouriteIndex = ButtonState.normal.index;
  int stopIndex = ButtonState.normal.index;
  int forwardIndex = ButtonState.normal.index;  

//  List<String> stopImages = [
//     'p_icon_48X48_power_icon.svg',
//   ];

  void _onTapSkipBackward() {
    if (!isFMPlaying) return;

    setState(() {
      widget.onTapSkipBackward();
      backwardIndex = ButtonState.selected.index;
      const oneDecimal = const Duration(milliseconds: 250);
      Timer? _timer;
      _timer = Timer(oneDecimal, () {
        setState(() {
          backwardIndex = ButtonState.normal.index;
        });
        _timer?.cancel();
      });
    });
  }

  void _onTapFavourite() {
    setState(() {
      isHeartFilled = !isHeartFilled;
      favouriteIndex = (favouriteIndex + 1) % favouriteImages.length;
    });
  }

  void _onTapPlay() {
    setState(() {
      isFMPlaying = !isFMPlaying;
      stopIndex = (stopIndex + 1) % stopImages.length;
      widget.toggleTapFreq(isFMPlaying);     
    });
  }

  void _onTapSkipForward() {
    if (!isFMPlaying) return;
    setState(() {
      widget.onTapSkipForward();
      widget.currentFrequencyValue = minFrequencyRange;
      forwardIndex = ButtonState.selected.index;
      const oneDecimal = Duration(milliseconds: 250);
      Timer?  _timer;
      _timer = Timer(oneDecimal, () {
        setState(() {
          forwardIndex = ButtonState.normal.index;
        });
        _timer?.cancel();
      });
    });
  }

  void _onTapTrackerIncrease() {
    widget.onTapTrackerIncrease();
  }

  void _onTapTrackerDecrease() {
    widget.onTapTrackerDecrease();
  }

  void _onTapTrackerStop() {
    widget.onTapTrackerStop();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 417,
      height: 48,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildContainer(
              ActionButtonCurrentEvent.onSkipBackward, _onTapSkipBackward),
          buildContainer(ActionButtonCurrentEvent.onFavourite, _onTapFavourite),
          buildContainer(ActionButtonCurrentEvent.onStop, _onTapPlay),
          buildContainer(
              ActionButtonCurrentEvent.onSkipForward, _onTapSkipForward),
        ],
      ),
    );
  }

  String getCurrentImageFileName(ActionButtonCurrentEvent event) {
    switch (event) {
      case ActionButtonCurrentEvent.onSkipBackward:
        return backwardkImages[
            isFMPlaying ? backwardIndex : ButtonState.unselected.index];
      case ActionButtonCurrentEvent.onFavourite:
        return favouriteImages[
            isFMPlaying ? favouriteIndex : ButtonState.unselected.index];
      case ActionButtonCurrentEvent.onStop:
        return stopImages[stopIndex];
      case ActionButtonCurrentEvent.onSkipForward:
        return forwardImages[
            isFMPlaying ? forwardIndex : ButtonState.unselected.index];
      default:
        return "";
    }
  }

  Widget buildContainer(ActionButtonCurrentEvent event, VoidCallback onTap) {
    String imagesFileName = getCurrentImageFileName(event);
    return SizedBox(
      width: generalHomeButtonWidth,
      height: generalHomeButtonHeight,
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () {
          if (event == ActionButtonCurrentEvent.onSkipBackward) {
            setState(() {
              backwardIndex = ButtonState.selected.index;
              _onTapTrackerDecrease();
            });
          } else if (event == ActionButtonCurrentEvent.onSkipForward) {
            setState(() {
              forwardIndex = ButtonState.selected.index;
              _onTapTrackerIncrease();
            });
          }
        },
        onLongPressEnd: (_) {
          if (event == ActionButtonCurrentEvent.onSkipBackward) {
            setState(() {
              backwardIndex = ButtonState.normal.index;
              _onTapTrackerStop();
            });
          } else if (event == ActionButtonCurrentEvent.onSkipForward) {
            setState(() {
              forwardIndex = ButtonState.normal.index;
              _onTapTrackerStop();
            });
          }
        },
        child: getSVGPictureAsset(imagesFileName, getFMImageFolderName(),
            svgImageWidth, svgImageHeight),
      ),
    );
  }
}
