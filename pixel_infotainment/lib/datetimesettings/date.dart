import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/gestures.dart';

class DateContent extends StatefulWidget {
  //call datecontent class(main function)
  final int day;
  final int month;
  final int year;
  final bool isCancelPressed;
  final bool isSavePressed;

  final Function(bool) updateDate;
  final Function(bool) updateMonth;
  final Function(bool) updateYear;
  final Function(bool) reset; //cancel&save

  DateContent({
    required this.day,
    required this.month,
    required this.year,
    required this.isCancelPressed,
    required this.isSavePressed,
    required this.updateDate,
    required this.reset,
    required this.updateMonth,
    required this.updateYear,
  });

  @override
  _DateContentState createState() => _DateContentState(); //call main class
}

class _DateContentState extends State<DateContent> {
  //declare
  late bool _isCancelPressed;
  late bool _isSavePressed;

  @override
  void initState() {
    super.initState();
    _isCancelPressed = widget.isCancelPressed;
    _isSavePressed = widget.isSavePressed;
  }

  void updateSavePressed(bool value) {
    setState(() {
      _isSavePressed = value; // value stores to is save pressed
    });
  }

  void updateCancelPressed(bool value) {
    setState(() {
      _isCancelPressed = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    //...............plus
    return Stack(
      children: [
        Positioned(
          left: 620.5,
          top: 180.00,
          child: GestureDetector(
            onTap: () => widget.updateDate(true), //value increment
            child: Container(
              width: 50.0,
              height: 50.0,
              child:
                  SvgPicture.asset('assets/images/datetimesettings/plus_day&month&year.svg'), //plus day
            ),
          ),
        ),
        Positioned(
          left: 828.5,
          top: 180.00,
          child: GestureDetector(
            onTap: () => widget.updateMonth(true),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/plus_day&month&year.svg', //pluse month
              ),
            ),
          ),
        ),
        Positioned(
          left: 1081.5,
          top: 180.00,
          child: GestureDetector(
            onTap: () => widget.updateYear(true),
            child: Container(
              width: 50.0,
              height: 50.0,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/plus_day&month&year.svg', //plus year
              ),
            ),
          ),
        ),
        // Additional Image 1
        Positioned(
          //.................box
          left: 597.0,
          top: 295.0,
          child: Container(
            width: 113.0,
            height: 113.0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset('assets/images/datetimesettings/box_day&month.svg'), //... day box
                Text(
                  '${widget.day}'.padLeft(2, '0'),
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
              "day",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),

        // Additional Image 2 with "/"
        Positioned(
          left: 740,
          top: 310.25,
          child: Container(
            width: 70.0,
            height: 70.0,
            child: Text(
              '/',
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 70.0,
                fontWeight: FontWeight.normal,
              ),
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
                  'assets/images/datetimesettings/box_day&month.svg', //.......... box for month
                ),
                Text(
                  '${widget.month}'.padLeft(2, '0'),
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
            child: Text(
              "Month",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),
        Positioned(
          left: 948.02,
          top: 305.5, // y
          child: Container(
            width: 70.0,
            height: 70.0,
            child: Text(
              '/',
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 70.0,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        // Additional Image 3
        Positioned(
          left: 1021.0, // x
          top: 300.0, // y
          child: Container(
            width: 185.0,
            height: 106.47,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/datetimesettings/box_year.svg', //.........box for year
                ),
                Text(
                  '${widget.year}'.padLeft(2, '0'),
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
            left: 1094.02,
            top: 409.71,
            // width: 43,
            // height: 40,
            child: Text(
              "Year",
              style: GoogleFonts.urbanist(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.normal,
              ),
            )),
        //..... Minus
        Positioned(
          left: 611.5,
          top: 470,
          child: GestureDetector(
            onTap: () => widget.updateDate(false),
            child: Container(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                  'assets/images/datetimesettings/minus_day&month&year.svg'), //........minus for day
            ),
          ),
        ),
        Positioned(
          left: 828.5, // x
          top: 470, // y
          child: GestureDetector(
            onTap: () => widget.updateMonth(false),
            child: Container(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/minus_day&month&year.svg', //........minus for month
              ),
            ),
          ),
        ),

        // Additional Image 3 - Minus
        Positioned(
          left: 1081.5, // x
          top: 470, // y
          child: GestureDetector(
            onTap: () => widget.updateYear(false),
            child: Container(
              width: 64,
              height: 64,
              child: SvgPicture.asset(
                'assets/images/datetimesettings/minus_day&month&year.svg', //..............minus for year
              ),
            ),
          ),
        ),
        Positioned(
          left: 780, // x
          top: 570.0, // y
          child: GestureDetector(
            onTapUp: (details) {
              //pressed
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

        ////////////////
        Positioned(
          left: 147,
          top: 90.5,
          child: Container(
            width: 50.0,
            height: 50.0,
            child: SvgPicture.asset(
              'assets/images/datetimesettings/arrow(date&time).svg', // ............top corner arrow
            ),
          ),
        ),
        Positioned(
            left: 214,
            top: 90,
            child: Text(
              "Date & Time settings", //................beside arrow text

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
