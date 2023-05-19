import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';

class DateTimePicker extends StatefulWidget {
  final double height;
  DateTimePicker({ @required this.height,Key key}) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  double get _height => widget.height;
  TimeOfDay selectedTime;
  DateTime selectedDate;

  Future _openTimePicker () async {
    TimeOfDay time = await showTimePicker(
      context: context, 
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    setState(() {
      selectedTime = time;
    });
  }
  
  Future _openDatePicker () async {
    DateTime date = await showDatePicker(
      context: context, 
      initialDate:  DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050)
    );
    setState(() {
      selectedDate = date;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      decoration: BoxDecoration(
        
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(padding: EdgeInsets.all(20)),
            icon: Icon(Icons.schedule),
            onPressed: _openTimePicker, 
            label: Text(
              selectedTime?.format(context) ?? TimeOfDay.now().format(context),
              style: TextStyle(
                fontSize: 24
              ),
            )
          ),
          TextButton.icon(
            style: TextButton.styleFrom(padding: EdgeInsets.all(20)),
            icon: Icon(Icons.calendar_month),
            onPressed: _openDatePicker, 
            label: Text(
              DateFormat.yMMMd().format(selectedDate ?? DateTime.now()),
              style: TextStyle(
                fontSize: 24
              ),
            )
          ),
        ],
      ),
    );
  }
}