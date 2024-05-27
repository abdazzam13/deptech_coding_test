import 'package:deptechcodingtest/view/Event/controller/EventController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class customDatePicker extends StatefulWidget {
  final EventController controller;

  customDatePicker({required this.controller});

  @override
  _customDatePickerState createState() => _customDatePickerState();
}

class _customDatePickerState extends State<customDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(Icons.calendar_month_sharp),
            SizedBox(width: 10),
            Text(
              "${widget.controller.selectedDate.day} ${widget.controller.getMonth(widget.controller.selectedDate.month)} ${widget.controller.selectedDate.year}",
            ),
            Spacer(),
            InkWell(
              onTap: () {
                setState(() {
                  widget.controller.isEditDate = !widget.controller.isEditDate;
                });
              },
              child: Icon(Icons.edit),
            ),
          ],
        ),
        if (widget.controller.isEditDate)
          CalendarDatePicker(
            initialDate: widget.controller.selectedDate,
            firstDate: widget.controller.firstDate,
            lastDate: widget.controller.lastDate,
            onDateChanged: (newDate) {
              setState(() {
                widget.controller.selectedDate = newDate;
              });
            },
          ),
      ],
    );
  }
}