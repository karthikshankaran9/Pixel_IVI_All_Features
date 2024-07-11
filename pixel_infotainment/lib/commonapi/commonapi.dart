import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget getImageAsset(
    String imagesFileName, String folderPath, double width, double height) {
  return Image.asset(
    "$folderPath/$imagesFileName",
    width: width,
    height: height,
  );
}

Widget getSVGPictureAsset(
    String imagesFileName, String folderPath, double width, double height) {
  return SvgPicture.asset(
    "$folderPath/$imagesFileName",
    width: width,
    height: height,
  );
}

Widget getGestureDetectorWidget(Function() onTapFuntion, String imagesFileName,
    String folderPath, double width, double height) {
  return GestureDetector(
    onTap: onTapFuntion,
    child: getSVGPictureAsset(imagesFileName, folderPath, width, height),
  );
}

Widget getPositionedWidget(double left, double top, Function() onTapFuntion,
    String imagesFileName, String folderPath, double width, double height) {
  return Positioned(
    left: left,
    top: top,
    child: getGestureDetectorWidget(
        onTapFuntion, imagesFileName, folderPath, width, height),
  );
}

Widget getPositionedContainerWithSVG(double left, double top,
    String imagesFileName, String folderPath, double width, double height) {
  return Positioned(
    left: left,
    top: top,
    child: getSVGPictureAsset(imagesFileName, folderPath, width, height),
  );
}

Widget getTextWidget(
    String text, Color color, double fontsize, FontWeight fontWeight) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontSize: fontsize,
      fontFamily: 'Urbanist',
      fontWeight: fontWeight,
    ),
  );
}

Widget getPositionedWithText(double left, double top, String text, Color color,
    double fontsize, FontWeight fontWeight) {
  return Positioned(
    left: left,
    top: top,
    child: getTextWidget(text, color, fontsize, fontWeight),
  );
}
