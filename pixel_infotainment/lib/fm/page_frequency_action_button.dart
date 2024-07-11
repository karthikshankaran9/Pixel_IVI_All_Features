import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:pixel_infotainment/commonapi/constant.dart';
import 'package:pixel_infotainment/commonapi/commonapi.dart';
import 'package:pixel_infotainment/fm/page_action_botton.dart';
import 'package:pixel_infotainment/fm/common/page_general_class.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int forwardIndex = ButtonState.normal.index;
  int backwardIndex = ButtonState.normal.index;
  bool isFMPlaying = true;
  double currentFrequencyValue = minFrequencyRange;
  Timer? _trackerTimer;

  static const platform = MethodChannel('com.example.pixel_infotainment/methodchannel');
  String _fmStationFrequencyValue = "";

  Future<void> _setStation() async {
    try {
      final String result = await platform.invokeMethod('setStation', {"frequencyValue": currentFrequencyValue});
      setState(() {
        _fmStationFrequencyValue = result;
      });
      // return result;
    } on PlatformException catch (e) {
      // _fmStationFrequencyValue  = 'Failed to invoke method: ${e.message}';
    }
  }

  final LongPressGestureRecognizer _longPressAdditionRecognizer =
      LongPressGestureRecognizer();
  final LongPressGestureRecognizer _longPressSubtractionRecognizer =
      LongPressGestureRecognizer();
    
  @override  
   void initState() {
    super.initState();
    _longPressAdditionRecognizer
      ..onLongPress = _onLongPressIncreaseFreq
      ..onLongPressEnd = _onLongPressFreqEnd;

    _longPressSubtractionRecognizer
      ..onLongPress = _onLongPressDecreaseFreq
      ..onLongPressEnd = _onLongPressFreqEnd;
  }

  void _onLongPressIncreaseFreq() {
    setState(() {
      forwardIndex = ButtonState.selected.index;
    });
    onTapTrackerIncrease();
  }

  void _onLongPressDecreaseFreq() {
    setState(() {
      backwardIndex = ButtonState.selected.index;
    });
    onTapTrackerDecrease();
  }

  void _onLongPressFreqEnd(LongPressEndDetails details) {
    onTapTrackerStop();
  }

  void onTapSkipBackward() {
    setState(() {
      currentFrequencyValue--;
      if (currentFrequencyValue < minFrequencyRange) {
        currentFrequencyValue = maxFrequencyRange;
      }
    });
    _setStation();
  }

  void onTapSkipForward() {
    setState(() {
      currentFrequencyValue++;
      if (currentFrequencyValue >= maxFrequencyRange) {
        currentFrequencyValue = minFrequencyRange;
      }
    });
    _setStation();
  }

  void onTapDecreaseFreq() {
    if (isFMPlaying) {
      setState(() {
        currentFrequencyValue -= 0.01;
        if (currentFrequencyValue < minFrequencyRange) {
          currentFrequencyValue = maxFrequencyRange;
        }
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
      _setStation();
    }
  }

  void onTapIncreaseFreq() {
    if (isFMPlaying) {
      setState(() {
        currentFrequencyValue += 0.01;
        if (currentFrequencyValue >= maxFrequencyRange) {
          currentFrequencyValue = minFrequencyRange;
        }
        forwardIndex = ButtonState.selected.index;
        const oneDecimal = const Duration(milliseconds: 250);
        Timer? _timer;
        _timer = Timer(oneDecimal, () {
          setState(() {
            forwardIndex = ButtonState.normal.index;
          });
          _timer?.cancel();
        });
      });
      _setStation();
    }
  }

  void onTapTrackerIncrease() {
    if (isFMPlaying) {
      _trackerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          currentFrequencyValue += 0.1;
          if (currentFrequencyValue >= maxFrequencyRange) {
            currentFrequencyValue = minFrequencyRange;
          }
          _setStation();
        });
      });
    }
  }

  void onTapTrackerDecrease() {
    if (isFMPlaying) {
      _trackerTimer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          currentFrequencyValue -= 0.1;
          if (currentFrequencyValue <= minFrequencyRange) {
            currentFrequencyValue = maxFrequencyRange;
          }
        });
        _setStation();
      });
    }
  }

  void onTapTrackerStop() {
    if (isFMPlaying) {
      _trackerTimer?.cancel();
      setState(() {
        backwardIndex = ButtonState.normal.index;
        forwardIndex = ButtonState.normal.index;
      });
      _setStation();
    }
  }

  @override
  Widget build(BuildContext context) {
    double minValue = minFrequencyRange;
    double maxValue = maxFrequencyRange;
    double totalWidth = 567.0;
    double minLeft = 92.0;

    double trackerLeftPosition = minLeft +
        ((currentFrequencyValue - minValue) / (maxValue - minValue)) *
            totalWidth;
    return SafeArea(
      child: Container(
        width: backgroundImageWidth,
        height: backgroundImageHeight,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${getFMImageFolderName()}/Background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            buildHeader(),
            buildTuneAndFavouriteButtons(),
            buildFrequencyRoundedArea(),
            buildSliderArea(trackerLeftPosition),
            ActionButtonPage(
              currentFrequencyValue: currentFrequencyValue,
              onTapFreqIncrease: onTapIncreaseFreq,
              onTapFreqDecrease: onTapDecreaseFreq,
              onTapTrackerIncrease: onTapTrackerIncrease,
              onTapTrackerDecrease: onTapTrackerDecrease,
              onTapTrackerStop: onTapTrackerStop,
              onTapSkipForward: onTapSkipForward,
              onTapSkipBackward: onTapSkipBackward,
              toggleTapFreq: (bool value) {
                setState(() {
                  isFMPlaying = value;
                  backwardIndex = isFMPlaying
                      ? ButtonState.normal.index
                      : ButtonState.unselected.index;
                  forwardIndex = isFMPlaying
                      ? ButtonState.normal.index
                      : ButtonState.unselected.index;
                });
              },
              increaseImages: increaseImages,
              forwardIndex: forwardIndex,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return SizedBox(
      width: 960,
      height: 200,
      child: Stack(
        children: [
          getPositionedContainerWithSVG(
            10,
            80,
            isFMPlaying
                ? "imgEnable _RadioIcon_selected.svg"
                : "imgDisabled_RadioIcon_unselected.svg",
            getFMImageFolderName(),
            100,
            100,
          ),
          Positioned(
            top: 40,
            child: SizedBox(
              width: 620,
              height: 170,
              child: Stack(
                children: [
                  Positioned(
                    left: 132,
                    top: 0,
                    child: SizedBox(
                      width: 490,
                      height: 170,
                      child: Stack(
                        children: [
                          if (isFMPlaying)
                            getPositionedWithText(
                              11,
                              110,
                             _fmStationFrequencyValue,
                              Colors.white,
                              42,
                              FontWeight.w500,
                            ),
                          isFMPlaying
                              ? getPositionedWithText(
                                  0,
                                  0,
                                  '${currentFrequencyValue.toStringAsFixed(2)}MHz',
                                  Colors.white,
                                  90,
                                  FontWeight.w500,
                                )
                              : Positioned(
                                  top: 100,
                                  child: getSVGPictureAsset(
                                    "imgDisabled_FreqAndChannelValue.svg",
                                    getFMImageFolderName(),
                                    40,
                                    10,
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTuneAndFavouriteButtons() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isFMPlaying
              ? getSVGPictureAsset("imgEnabled_Button_Tune_selected.svg",
                  getFMImageFolderName(), 216, 78)
              : getSVGPictureAsset("imgDisabled_Button_Tune_unselected.svg",
                  getFMImageFolderName(), 216, 78),
          const SizedBox(width: 26),
          getSVGPictureAsset(
              isFMPlaying
                  ? "imgEnabled_Button_Favourite_selected.svg"
                  : "imgDisabled_Button_Favourite_unselected.svg",
              getFMImageFolderName(),
              272,
              78),
        ],
      ),
    ),
  );
}

  Widget buildFrequencyRoundedArea() {
    return SizedBox(
      width: 728,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
                Visibility(
                  visible: isFMPlaying,
                  child: GestureDetector(
            onTap: () {
              backwardIndex = (backwardIndex + 1) % decreaseImages.length;
              onTapDecreaseFreq();
            },
            onLongPress: _longPressSubtractionRecognizer.onLongPress,
            onLongPressEnd: _longPressSubtractionRecognizer.onLongPressEnd,
            child: getSVGPictureAsset(decreaseImages[backwardIndex],
                getFMImageFolderName(), svgImageWidth, svgImageHeight),
          ),
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Stack(
                    children: [
                      isFMPlaying
                          ? getSVGPictureAsset(
                              "Radio_Alert_roundeed_rectandle.svg",
                              getFMImageFolderName(),
                              572,
                              120,
                            )
                          : Center(
                              child: getSVGPictureAsset(
                                "imgDisabled_Radio_Alert_item_WarningwithText.svg",
                                getFMImageFolderName(),
                                306,
                                169,
                              ),
                            ),
                      if (isFMPlaying)
                        Container(
                          alignment: Alignment.center,
                          child: getTextWidget(
                              currentFrequencyValue.toStringAsFixed(2),
                              Colors.white,
                              100,
                              FontWeight.w500),
              ),
            ],
          ),
          ),
         Visibility(
         visible: isFMPlaying,
                  
        child:  GestureDetector(
            onTap: () {
              forwardIndex = (forwardIndex + 1) % increaseImages.length;
              onTapIncreaseFreq();
            },
            onLongPress: _longPressAdditionRecognizer.onLongPress,
            onLongPressEnd: _longPressAdditionRecognizer.onLongPressEnd,
            child: getSVGPictureAsset(increaseImages[forwardIndex],
                getFMImageFolderName(), svgImageWidth, svgImageHeight),
                 ),
                ),
              ],
            ),
          );
  }

  Widget buildSliderArea(double trackerLeftPosition) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (isFMPlaying) {
          setState(() {
            double dx = details.localPosition.dx;
            if (dx >= 92 && dx <= 659) {
              trackerLeftPosition = dx;
              double ratio = (dx - 92) / 567;
              currentFrequencyValue = minFrequencyRange +
                  ratio * (maxFrequencyRange - minFrequencyRange);
            }
          });
          _setStation();
        }
      },
      child: SizedBox(
        width: 780,
        height: 265,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 90,
              child: SizedBox(
                width: 860,
                height: 64,
                child: Stack(
                  children: [
                    if (isFMPlaying)
                      getPositionedWithText(
                          0,
                          14,
                          minFrequencyRange.toStringAsFixed(2),
                          Colors.white,
                          30,
                          FontWeight.w500),
                    if (isFMPlaying)
                      getPositionedWithText(
                          679,
                          14,
                          maxFrequencyRange.toStringAsFixed(2),
                          Colors.white,
                          30,
                          FontWeight.w500),
                  ],
                ),
              ),
            ),
            isFMPlaying
                ? getPositionedContainerWithSVG(
                    92,
                    118,
                    "tracker_567X18_fm_background_selected.svg",
                    getFMImageFolderName(),
                    566,
                    18)
                : getPositionedContainerWithSVG(12, 118, "item_tracker_fm_background_unselected.svg",
                    getFMImageFolderName(), 860, 64),
            if (isFMPlaying)
              getPositionedContainerWithSVG(trackerLeftPosition, 95,
                  "tracker_9X64_fm_background_selected_slider.svg", getFMImageFolderName(), 8, 64),
          ],
        ),
      ),
    );
  }
}
