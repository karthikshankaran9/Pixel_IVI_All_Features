import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class TimeContent extends StatefulWidget {
  final int hour;
  final int minute;
  final bool isCancelPressed;
  final bool isSavePressed;
   

  final Function(bool,bool) updateHour;
  final Function(bool) timeConversion;
  final Function(bool) updateMinute;
  final Function(bool) reset;

  TimeContent({
    required this.hour,
    required this.minute,
    required this.isCancelPressed,
    required this.isSavePressed,
    required this.updateHour,
    required this.timeConversion,
    required this.reset,
    required this.updateMinute,
    
  });

  @override
  _TimeContentState createState() => _TimeContentState();
}

class _TimeContentState extends State<TimeContent> {
  late bool _isCancelPressed;
  late bool _isSavePressed;
  bool isVisible = false; //format
  bool railwayTimeEnabled = false; //format
  bool isAmPressed=false;
  bool isPmPressed=false;
  bool is24Pressed=false;
  bool is12Pressed=false;
  

  @override
  void initState() {
    super.initState();
    _isCancelPressed = widget.isCancelPressed;
    _isSavePressed = widget.isSavePressed;
  }

  void updateSavePressed(bool value) {
    setState(() {
      _isSavePressed = value;
    });
  }

  void updateCancelPressed(bool value) {
    setState(() {
      _isCancelPressed = value;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 620.5,
          top: 180.00,
          child: GestureDetector(
            onTap: () => widget.updateHour(true,railwayTimeEnabled),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: SvgPicture.asset(
                  'assets/images/datetimesettings/plus_day&month&year.svg'), //.............hours plus
            ),
          ),
        ),
        Positioned(
          left: 828.5,
          top: 180.00,
          child: GestureDetector(
            onTap: () => widget.updateMinute(true),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/plus_day&month&year.svg', //...................minute plus
              ),
            ),
          ),
        ),      
         Positioned(
          left: 800.5,
          top: 2.00,
          child: GestureDetector(
            onTap: () {
              setState(() {
                railwayTimeEnabled = !railwayTimeEnabled;
                widget.timeConversion(railwayTimeEnabled);
              });
            },
            child: Container(
              width: 100.0,
              height: 200.0,
              child: SvgPicture.asset(
                railwayTimeEnabled
                ? 'assets/images/datetimesettings/24&12_pressed_format.svg'
                : 'assets/images/datetimesettings/12&24_default_format.svg'
              ),
            ),
          ),
        ),
        Positioned(
          left: 716,
          top: 70,
          child: Text(
            '24h',
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
        ),
        Positioned(
          left: 920,
          top: 70,
          child: Text(
            '12h',
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 40.0,
            ),
          ),
        ),
        Positioned(
          left: 1065.5,
          top: 280.00,
          child: railwayTimeEnabled
              ? Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPmPressed = false;
                          isAmPressed = true;
                        });
                      },
                      child: Container(
                        width: 120.0,
                        height: 60.0,
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            isAmPressed
                            ? 'assets/images/datetimesettings/am_pm_pressed.svg'
                            : 'assets/images/datetimesettings/am_pm_default.svg',
                          ),
                          Text(
                            'am',
                            style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ),
        Positioned(
          left: 1065.5,
          top: 390.00,
          child: railwayTimeEnabled
              ? Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isPmPressed = true;
                          isAmPressed = false;
                        });
                      },
                      child: Container(
                        width: 120.0,
                        height: 60.0,
                        child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SvgPicture.asset(
                            isPmPressed
                            ? 'assets/images/datetimesettings/am_pm_pressed.svg'
                            : 'assets/images/datetimesettings/am_pm_default.svg',
                          ),
                          Text(
                            'pm',
                            style: GoogleFonts.urbanist(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
        ),

        // Additional Image 1
        Positioned(
          left: 597.0,
          top: 295.0,
          child: Container(
            width: 113.0,
            height: 113.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                    'assets/images/datetimesettings/box_day&month.svg'), //...........box for hours
                Text(
                  '${widget.hour}'.padLeft(2, '0'),
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 70.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 629,
            top: 410,
            child: Text(
              "hours",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),

        // Additional Image 2 with "/"
        Positioned(
          left: 740,
          top: 290.25,
          child: Text(
            ':',
            style: GoogleFonts.urbanist(
              color: Colors.white,
              fontSize: 70.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Positioned(
          left: 804.0, // x
          top: 300.0, // y
          child: Container(
            width: 113.0,
            height: 113.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/datetimesettings/box_day&month.svg', //.................box for minutes
                ),
                Text(
                  '${widget.minute}'.padLeft(2, '0'),
                  style: GoogleFonts.urbanist(
                    color: Colors.white,
                    fontSize: 70.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            left: 835.02,
            top: 410,
            // width: 43,
            // height: 40,
            child: Text(
              "minutes",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),

        // Additional Image 1 - Minus
        Positioned(
          left: 611.5,
          top: 470,
          child: GestureDetector(
            onTap: () => widget.updateHour(false,railwayTimeEnabled),
            child: Container(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                  'assets/images/datetimesettings/minus_day&month&year.svg'), //..........minus for hours
            ),
          ),
        ),

        // Additional Image 2 - Minus
        Positioned(
          left: 828.5, // x
          top: 470, // y
          child: GestureDetector(
            onTap: () => widget.updateMinute(false),
            child: Container(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/minus_day&month&year.svg', //.................minus for minutes
              ),
            ),
          ),
        ),

        // Additional Image 3 - Minus

        Positioned(
          left: 780, // x
          top: 570.0, // y
          child: GestureDetector(
            onTapUp: (details) {
              updateSavePressed(false);
            },
            onTapDown: (details) {
              updateSavePressed(true);
            },
            child: Container(
              width: 185.0,
              height: 106.47,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    _isSavePressed
                        ? 'assets/images/datetimesettings/save&cancel_pressed.svg'
                        : 'assets/images/datetimesettings/save&cancel(default).svg',
                  ),
                  Text(
                    'save',
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 1030,
          top: 570.0,
          child: GestureDetector(
            onTapUp: (details) {
              updateCancelPressed(false);
              widget.reset(true);
            },
            onTapDown: (details) {
              updateCancelPressed(true);
            },
            child: Container(
              width: 185.0,
              height: 106.47,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    _isCancelPressed
                        ? 'assets/images/datetimesettings/save&cancel_pressed.svg'
                        : 'assets/images/datetimesettings/save&cancel(default).svg',
                  ),
                  Text(
                    'Cancel',
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        Positioned(
          left: 147,
          top: 90.5,
          child: Container(
            width: 50.0,
            height: 50.0,
            child: SvgPicture.asset(
              'assets/images/datetimesettings/arrow(date&time).svg',
            ),
          ),
        ),
        Positioned(
            left: 214,
            top: 90,
            child: Text(
              "Date & Time settings",
              style: GoogleFonts.urbanist(
                color: const Color.fromARGB(255, 113, 184, 241),
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
              ),
            )),
      ],
    );
  }
}
