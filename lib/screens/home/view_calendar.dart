import 'package:googleapis/calendar/v3.dart';
import 'package:mem_bank/services/auth.dart';
import 'package:flutter/material.dart';

class ViewCalendar extends StatefulWidget {
  const ViewCalendar({Key? key}) : super(key: key);

  @override
  State<ViewCalendar> createState() => _ViewCalendarState();
}

class _ViewCalendarState extends State<ViewCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //child: FutureBuilder(
        //future: getGoogleEventsData(),
      //),
    );
  }
}
