import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixel_infotainment/datetimesettings/time.dart';
import 'package:pixel_infotainment/datetimesettings/date.dart';
// import 'package:flutter/gestures.dart';

//state create (main class)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() =>
      _HomePageState(); //runtime change the object state
}

class _HomePageState extends State<HomePage> {
  int day = DateTime.now().day; //global state
  int month = DateTime.now().month;
  int year = DateTime.now().year;
  bool isCancelPressed = false;
  bool isSavePressed = false;
  bool isDateButtonPressed = true;
  bool isTimeButtonPressed = false;

  bool isDatePressed = false;
  bool isTimePressed = false;

  int hour = DateTime.now().hour;
  int minute = DateTime.now().minute;

  int currentPageIndex = 0;
  int timeformateIndex = 0; //me
  void updateDate(bool increment) {
    setState(() {
      if (increment) {
        day = (day < daysInMonth()) ? day + 1 : 1; //increment
      } else {
        if (day == 0) {
          day = daysInMonth();
        } else {
          day = ((day - 2) % daysInMonth()) + 1; //decrement
        }
      }

      if (!increment && day == 31) {
        // checks if decrement is pressed and day is 31 when pressed
        if (month == 1) {
          //------------checks if month is jan
          month = 12; // to dec
          year--;
        } else {
          month--;
        }
      } else if (increment && day == 1) {
        //checks if increment is pressed and day is 1 when pressed
        if (month == 12) {
          //..checks if month is dec
          month = 1; //  to jan
          year++;
        } else {
          month++;
        }
      }
    });
  }

  int daysInMonth() {
    //for feb
    if (month == 2) {
      return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0))
          ? 29
          : 28; //leap year
    } else if (month % 2 == 0) {
      return 30; //even month
    } else {
      return 31; //odd month
    }
  }

  void updateMonth(bool increment) {
    setState(() {
      if (increment) {
        month = (month % 12) + 1;
      } else {
        if (month == 0) {
          month = 12;
        } else {
          month = (month - 2 + 12) % 12 + 1; //decerement
        }
      }
    });
  }

  void updateYear(bool increment) {
    setState(() {
      year = increment
          ? year + 1
          : year - 1; //pressed increment year will be increase
    });
  }

  void resetDate(bool dummy) {
    setState(() {
      day = 0;
      month = 0;
      year = DateTime.now().year;
    });
  }

  void resetTime(bool dummy) {
    setState(() {
      hour = 0;
      minute = 0;
    });
  }

  void TimeConversion(bool railwayTimeEnabled) {
    setState(() {
      if (railwayTimeEnabled) {
        hour = (hour % 12);

        if (hour == 0) {
          hour = 12;
        }
      }
    });
  }

  void updateHour(bool increment, bool railwayTimeEnabled) {
    setState(() {
      var hr = 12;

      if (!railwayTimeEnabled) {
        hr = 24;
      }
      if (increment) {
        hour = (hour % hr) + 1;
      } else {
        hour = (hour - 2 + hr) % hr + 1;
      }

      if (hour == 24) {
        hour = 0;
      }
    });
  }

  void updateMinute(bool increment) {
    setState(() {
      if (increment) {
        minute = (minute % 60) + 1;
      } else {
        minute = (minute - 2 + 60) % 60 + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Time'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/datetimesettings/WallPaper5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            if (currentPageIndex == 0)
              DateContent(
                //parameters
                day: day,
                month: month,
                year: year,
                updateDate: updateDate,
                updateMonth: updateMonth,
                updateYear: updateYear,
                reset: resetDate,
                isSavePressed: isSavePressed,
                isCancelPressed: isCancelPressed,
              )
            else if (currentPageIndex == 1)
              TimeContent(
                hour: hour,
                minute: minute,
                updateHour: updateHour,
                timeConversion: TimeConversion,
                updateMinute: updateMinute,
                reset: resetTime,
                isSavePressed: isSavePressed,
                isCancelPressed: isCancelPressed,
              ),
            Positioned(
              left: 160,
              top: 212,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentPageIndex = 0; //index page
                    isDateButtonPressed = true;
                    isTimeButtonPressed = false;
                  });
                },
                child: Container(
                  width: 319,
                  height: 72,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        isDateButtonPressed
                            ? 'assets/images/datetimesettings/rectange_date&time_pressed.svg'
                            : 'assets/images/datetimesettings/rectangle_date&time(default).svg',
                      ),
                      Text(
                        'Date',
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
              left: 160,
              top: 300,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    currentPageIndex = 1;
                    isDateButtonPressed = false;
                    isTimeButtonPressed = true;
                  });
                },
                child: Container(
                  width: 319,
                  height: 72,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        isTimeButtonPressed
                            ? 'assets/images/datetimesettings/rectange_date&time_pressed.svg'
                            : 'assets/images/datetimesettings/rectangle_date&time(default).svg',
                      ),
                      Text(
                        'Time',
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
          ],
        ),
      ),
    );
  }
}
