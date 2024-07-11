import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int value1 = 20; // Initial value for the first fan_bg
  int value2 = 4; // Initial value for the second fan_bg
  int value3 = 4; // Initial value for the third fan_bg

  double fanGearTop = 292; // Initial top position for fan gear
  double initialTop = 292;
  double endTop = 433;
  bool frontSelected = false;
  bool bodySelected = false;
  bool footSelected = false;
  bool rearSelected = false;
  bool isOn = true;
  bool isGearAtStart = true;
  bool allowDragging = true;

  void increaseValue(int fanId) {
    setState(() {
      if (fanId == 1 && value1 < 30) {
        value1++;
      } else if (fanId == 2 && value2 < 8) {
        value2++;
      } else if (fanId == 3 && value3 < 8) {
        value3++;
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if ((fanGearTop - initialTop).abs() < (fanGearTop - endTop).abs()) {
        fanGearTop = initialTop;
        isGearAtStart = true;
      } else {
        fanGearTop = endTop;
        isGearAtStart = false;
      }
    });
  }

  void decreaseValue(int fanId) {
    setState(() {
      if (fanId == 1 && value1 > 15) {
        value1--;
      } else if (fanId == 2 && value2 > 0) {
        value2--;
      } else if (fanId == 3 && value3 > 0) {
        value3--;
      }
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      fanGearTop += details.delta.dy;
      fanGearTop = fanGearTop.clamp(initialTop, endTop);
    });
  }

  int selectedTextStyle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/hvac/hcar_y2402_wallpaper.png",
              fit: BoxFit.cover,
            ),
          ),
          // Fan 2 Controls
          Positioned(
            left: 507,
            top: 636.33,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SvgPicture.asset(
                  isOn
                      ? "assets/images/hvac/fan_bg.svg"
                      : "assets/images/hvac/widget_611X72_fan_state_disabled.svg",
                ),
                Positioned(
                  left: 27,
                  bottom: 33.06,
                  child: Visibility(
                    visible: isOn,
                    child: value2 > 0
                        ? SvgPicture.asset("assets/images/hvac/fan_on.svg")
                        : SvgPicture.asset("assets/images/hvac/fan_off.svg"),
                  ),
                ),
                Positioned(
                  left: 27,
                  bottom: 33.06,
                  child: Visibility(
                    visible: !isOn,
                    child: SvgPicture.asset(
                        "assets/images/hvac/icon_64X64_fan_disabled.svg"),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: Text(
                    isOn ? '$value2' : '0',
                    style: TextStyle(
                      fontSize: 50,
                      color: isOn ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 429,
            top: 672.33,
            child: GestureDetector(
              onTap: () {
                if (value1 > 8 || !isOn) {
                  decreaseValue(2);
                }
              },
              child: SvgPicture.asset(
                value2 > 0 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_minus_enabled.svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_minus_disable .svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          Positioned(
            left: 720,
            top: 672.33,
            child: GestureDetector(
              onTap: () {
                if (value2 < 8 || !isOn) {
                  increaseValue(2);
                }
              },
              child: SvgPicture.asset(
                value2 < 8 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_enable .svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_disable.svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          // Fan 3 Controls
          Positioned(
            left: 941,
            top: 636.33,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SvgPicture.asset(
                  isOn
                      ? "assets/images/hvac/fan_bg.svg"
                      : "assets/images/hvac/widget_611X72_fan_state_disabled.svg",
                ),
                Positioned(
                  left: 27,
                  bottom: 33.06,
                  child: Visibility(
                    visible: isOn,
                    child: value3 > 0
                        ? SvgPicture.asset("assets/images/hvac/fan_on.svg")
                        : SvgPicture.asset("assets/images/hvac/fan_off.svg"),
                  ),
                ),
                Positioned(
                  left: 27,
                  bottom: 33.06,
                  child: Visibility(
                    visible: !isOn,
                    child: SvgPicture.asset(
                        "assets/images/hvac/icon_64X64_fan_disabled.svg"),
                  ),
                ),
                Positioned(
                  right: 20,
                  child: Text(
                    isOn ? '$value3' : '0',
                    style: TextStyle(
                      fontSize: 50,
                      color: isOn ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 863,
            top: 672.33,
            child: GestureDetector(
              onTap: () {
                if (value1 > 8 || !isOn) {
                  decreaseValue(3);
                }
              },
              child: SvgPicture.asset(
                value3 > 0 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_minus_enabled.svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_minus_disable .svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          Positioned(
            left: 1149,
            top: 672.33,
            child: GestureDetector(
              onTap: () {
                if (value3 < 8 || !isOn) {
                  increaseValue(3);
                }
              },
              child: SvgPicture.asset(
                value3 < 8 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_enable .svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_disable.svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          // Temperature Controls
          Positioned(
            left: 266,
            top: 600,
            child: GestureDetector(
              onTap: () {
                if (value1 > 15 || !isOn) {
                  decreaseValue(1);
                }
              },
              child: SvgPicture.asset(
                value1 > 15 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_minus_enabled.svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_minus_disable .svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          Positioned(
            left: 223,
            top: 678.67,
            child: Text(
              isOn ? '$value1 °C' : ' 0 °C',
              style: TextStyle(
                fontSize: 50,
                color: isOn ? Colors.white : Colors.grey,
              ),
            ),
          ),
          Positioned(
            left: 266,
            top: 150.67,
            child: GestureDetector(
              onTap: () {
                if (value1 < 30 || !isOn) {
                  increaseValue(1);
                }
              },
              child: SvgPicture.asset(
                value1 < 30 && isOn
                    ? "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_enable .svg"
                    : "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_plus_disable.svg",
                width: 48,
                height: 48,
              ),
            ),
          ),
          // Add this inside the Stack widget where you want to display the new SVG image
          Stack(
            children: [
              Positioned(
                left: 250, // Adjust position according to your layout
                top: 228.67, // Adjust position according to your layout
                child: SvgPicture.asset(
                  "assets/images/hvac/hcar_y2402_hvac_bg&lshade1.svg",
                  width: 80,
                  height: 344,
                ),
              ),
              if ((value1 == 30) && (isOn))
                Positioned(
                  left: 250,
                  top: 253,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_9.svg"),
                ),
              if ((value1 >= 27) && (isOn))
                Positioned(
                  left: 250,
                  top: 283,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_8.svg"),
                ),
              if ((value1 >= 25.5) && (isOn))
                Positioned(
                  left: 250,
                  top: 313,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_7.svg"),
                ),
              if ((value1 >= 24) && (isOn))
                Positioned(
                  left: 250,
                  top: 343,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_6.svg"),
                ),
              if ((value1 >= 22.5) && (isOn))
                Positioned(
                  left: 250,
                  top: 373,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_5.svg"),
                ),
              if ((value1 >= 21) && (isOn))
                Positioned(
                  left: 250,
                  top: 403,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_4.svg"),
                ),
              if ((value1 >= 19.5) && (isOn))
                Positioned(
                  left: 250,
                  top: 433,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_3.svg"),
                ),
              if ((value1 >= 18) && (isOn))
                Positioned(
                  left: 250,
                  top: 463,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_2.svg"),
                ),
              if ((value1 >= 16.5) && (isOn))
                Positioned(
                  left: 250,
                  top: 493,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_1.svg"),
                ),
              if ((value1 >= 15) && (isOn))
                Positioned(
                  left: 250,
                  top: 523,
                  child: SvgPicture.asset(
                      "assets/images/hvac/hcar_y2402_hvac_temperature_lvl_enable_0.svg"),
                ),
              // Positioned(
              //   left: 289, // Adjust position according to your layout
              //   top: 252.67, // Adjust position according to your layout
              //   child: SvgPicture.asset(
              //     "assets/images/hvac/temp_line.svg",
              //     width: 2,
              //     height: 296,
              //   ),
              // ),
              // Positioned(
              //   left: 262, // Adjust position according to your layout
              //   top: 388.67 -
              //       (value1 - 22) * 20, // Adjust position based on value1
              //   child: SvgPicture.asset(
              //     "assets/images/hvac/Microphone_BG.svg",
              //     width: 60,
              //     height: 40,
              //   ),
              // ),
              Positioned(
                left: 1106,
                top: 162,
                child: SvgPicture.asset(
                  isGearAtStart && isOn
                      ? "assets/images/hvac/widget_icon_100X100_defogger_front_selected.svg"
                      : "assets/images/hvac/widget_icon_100X100_defogger_front_normal.svg",
                  width: 100,
                  height: 100,
                ),
              ),
              Positioned(
                left: 1106,
                top: 498,
                child: SvgPicture.asset(
                  isGearAtStart
                      ? "assets/images/hvac/widget_icon_100X100_defogger_rear_default.svg"
                      : "assets/images/hvac/widget_icon_100X100_defogger_rear_selected.svg",
                  width: 100,
                  height: 100,
                ),
              ),
              Positioned(
                left: 1151,
                top: 292, // Adjust position according to your layout
                child: SvgPicture.asset(
                  "assets/images/hvac/hcar_y2402_hvac_fan_gear_line.svg",
                  width: 10,
                  height: 176,
                ),
              ),
              Positioned(
                left: 1115, // Adjust position according to your layout
                top: fanGearTop, // Dynamically adjust top position
                child: GestureDetector(
                  // Conditionally set onVerticalDragUpdate and onVerticalDragEnd callbacks
                  onVerticalDragUpdate:
                      allowDragging && isOn ? _onVerticalDragUpdate : null,
                  onVerticalDragEnd:
                      allowDragging && isOn ? _onVerticalDragEnd : null,
                  child: SvgPicture.asset(
                    "assets/images/hvac/hcar_y2402_hvac_fan_gear.svg",
                    width: 88,
                    height: 37,
                  ),
                ),
              ),
            ],
          ),
          // Column of Text Widget
          Container(
            child: Positioned(
              left: 320,
              top: 230,
              child: Column(
                children: [
                  for (var text in ['OFF', 'ECO', 'AUTO', 'TURBO'])
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: isOn
                                ? () {
                                    setState(() {
                                      selectedTextStyle = text == 'OFF'
                                          ? 1
                                          : text == 'ECO'
                                              ? 2
                                              : text == 'AUTO'
                                                  ? 3
                                                  : 4;
                                    });
                                  }
                                : null, // onTap is null when isOn is false
                            child: Container(
                              width: 270, // Set fixed width here
                              child: Text(
                                text,
                                textAlign:
                                    TextAlign.center, // Align text to center
                                style: TextStyle(
                                  fontSize: selectedTextStyle ==
                                              (text == 'OFF'
                                                  ? 1
                                                  : text == 'ECO'
                                                      ? 2
                                                      : text == 'AUTO'
                                                          ? 3
                                                          : 4) &&
                                          isOn
                                      ? 70.0
                                      : 30.0,
                                  fontWeight: selectedTextStyle ==
                                              (text == 'OFF'
                                                  ? 1
                                                  : text == 'ECO'
                                                      ? 2
                                                      : text == 'AUTO'
                                                          ? 3
                                                          : 4) &&
                                          isOn
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isOn &&
                                          selectedTextStyle ==
                                              (text == 'OFF'
                                                  ? 1
                                                  : text == 'ECO'
                                                      ? 2
                                                      : text == 'AUTO'
                                                          ? 3
                                                          : 4)
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30), // Add space between texts
                        ],
                      ),
                    ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),

          Positioned(
            left: 880.17,
            top: 248.87,
            child: SvgPicture.asset(
              "assets/images/hvac/hcar_y2402_hvac_defogger_person_icon.svg",
              width: 125.83,
              height: 261.67,
            ),
          ),
          Stack(
            children: [
              // Front Defogger background
              Positioned(
                left: 706,
                top: 143,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_front_defogger_bg_default.svg",
                        width: 167.35,
                        height: 194.83,
                      ),
                    ),
                    if (frontSelected && isOn)
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_front_defogger_bg_selected.svg",
                        width: 167.35,
                        height: 194.83,
                      ),
                  ],
                ),
              ),
              // Body Defogger background
              Positioned(
                left: 747.82,
                top: 212.32,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_body_defogger_bg_default.svg",
                        width: 194.83,
                        height: 167.35,
                      ),
                    ),
                    if (bodySelected && isOn)
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_body_defogger_bg_selected.svg",
                        width: 194.83,
                        height: 167.35,
                      ),
                  ],
                ),
              ),
              // Foot Defogger background
              Positioned(
                left: 747.84,
                top: 379.66,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_foot_defogger_bg_default.svg",
                        width: 194.83,
                        height: 167.35,
                      ),
                    ),
                    if (footSelected && isOn)
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_foot_defogger_bg_selected.svg",
                        width: 194.83,
                        height: 167.35,
                      ),
                  ],
                ),
              ),
              // Rear Defogger background
              Positioned(
                left: 706,
                top: 421.5,
                child: Stack(
                  children: [
                    GestureDetector(
                      child: SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_rear_defogger_bg_default.svg",
                        width: 167.35,
                        height: 194.84,
                      ),
                    ),
                    if (rearSelected && isOn)
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_rear_defogger_bg_selected.svg",
                        width: 167.35,
                        height: 194.84,
                      ),
                  ],
                ),
              ),
              // Front Defogger icon
              Positioned(
                left: 737.66,
                top: 237.16,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      frontSelected = !frontSelected;
                    });
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_front_defogger_icon_default.svg",
                        width: 45,
                        height: 34.29,
                      ),
                      if (isOn && frontSelected)
                        SvgPicture.asset(
                          "assets/images/hvac/hcar_y2402_hvac_front_defogger_icon_selected.svg",
                          width: 45,
                          height: 34.29,
                        ),
                    ],
                  ),
                ),
              ),
              // Body Defogger icon
              Positioned(
                left: 806.84,
                top: 293,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      bodySelected = !bodySelected;
                    });
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_body_defogger_icon_default.svg",
                        width: 37.99,
                        height: 45,
                      ),
                      if (isOn && bodySelected)
                        SvgPicture.asset(
                          "assets/images/hvac/hcar_y2402_hvac_body_defogger_icon_selected.svg",
                          width: 37.99,
                          height: 45,
                        ),
                    ],
                  ),
                ),
              ),
              // Foot Defogger icon
              Positioned(
                left: 808.5,
                top: 406.33,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      footSelected = !footSelected;
                    });
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_foot_defogger_icon_default.svg",
                        width: 35.27,
                        height: 45,
                      ),
                      if (isOn && footSelected)
                        SvgPicture.asset(
                          "assets/images/hvac/hcar_y2402_hvac_foot_defogger_icon_selected.svg",
                          width: 35.27,
                          height: 45,
                        ),
                    ],
                  ),
                ),
              ),
              // Rear Defogger icon
              Positioned(
                left: 737.66,
                top: 472.16,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      rearSelected = !rearSelected;
                    });
                  },
                  child: Stack(
                    children: [
                      SvgPicture.asset(
                        "assets/images/hvac/hcar_y2402_hvac_rear_defogger_icon_default.svg",
                        width: 45,
                        height: 38.2,
                      ),
                      if (isOn && rearSelected)
                        SvgPicture.asset(
                          "assets/images/hvac/hcar_y2402_hvac_rear_defogger_icon_selected.svg",
                          width: 45,
                          height: 38.2,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Positioned(
            left: 656,
            top: 329.25,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isOn = !isOn;
                });
              },
              child: SvgPicture.asset(
                isOn
                    ? "assets/images/hvac/hvac_frozen_icon.svg"
                    : "assets/images/hvac/button_100X100_frozen_icon_disabled.svg",
                width: 100,
                height: 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
