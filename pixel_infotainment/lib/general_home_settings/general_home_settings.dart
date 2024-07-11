import 'package:flutter/material.dart';
import 'package:pixel_infotainment/commonapi/constant.dart';
import 'package:pixel_infotainment/commonapi/commonapi.dart';
import 'package:pixel_infotainment/musicplayer/common/page_common_controls_ui.dart';

class GeneralHomeButton extends StatelessWidget {
  const GeneralHomeButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 82,
          width: 128,
          height: 552,
          child: SizedBox(
            width: 80,
            child: Stack(
              children: [
                getSVGPictureAsset("background_128X552.svg",
                    getMusicPlayerImageFolderName(), 128, 552),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        getSVGPictureAsset(
                            "p_icon_48X48_home.svg",
                            getMusicPlayerImageFolderName(),
                            generalHomeButtonWidth,
                            generalHomeButtonHeight),
                        const SizedBox(
                          height: 40,
                        ),
                        getSVGPictureAsset(
                            "p_icon_48X48_app_drawer.svg",
                            getMusicPlayerImageFolderName(),
                            generalHomeButtonWidth,
                            generalHomeButtonHeight),
                        const SizedBox(
                          height: 40,
                        ),
                        getSVGPictureAsset(
                            "p_icon_48X48_media.svg",
                            getMusicPlayerImageFolderName(),
                            generalHomeButtonWidth,
                            generalHomeButtonHeight),
                        const SizedBox(
                          height: 40,
                        ),
                        getSVGPictureAsset(
                            "p_icon_48X48_bluetooth.svg",
                            getMusicPlayerImageFolderName(),
                            generalHomeButtonWidth,
                            generalHomeButtonHeight),
                        const SizedBox(
                          height: 40,
                        ),
                        getSVGPictureAsset(
                            "p_icon_48X48_vehicle.svg",
                            getMusicPlayerImageFolderName(),
                            generalHomeButtonWidth,
                            generalHomeButtonHeight),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 672,
          width: 128,
          height: 128,
          child: Stack(
            children: [
              getSVGPictureAsset("background_128X128.svg",
                  getMusicPlayerImageFolderName(), 128, 128),
              Positioned(
                left: 40,
                top: 40,
                child: getSVGPictureAsset(
                    "p_icon_48X48_mic.svg",
                    getMusicPlayerImageFolderName(),
                    generalHomeButtonWidth,
                    generalHomeButtonHeight),
              )
            ],
          ),
        ),
      ],
    );
  }
}
