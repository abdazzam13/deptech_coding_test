import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Event/controller/EventController.dart';

class customTimePicker extends StatelessWidget {
  const customTimePicker({
    super.key,
    required this.controller,
    required this.context,
  });

  final EventController controller;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.selectTime(context);
          },
          child: Icon(Icons.access_time),
        ),
        SizedBox(width: 10),
        Text(
            "${controller.selectedTime.hour} : ${controller.selectedTime.minute} WIB"),
        Spacer(),
        InkWell(
          onTap: () {
            controller.selectTime(context);
          },
          child: Icon(Icons.edit),
        ),
      ],
    );
  }
}