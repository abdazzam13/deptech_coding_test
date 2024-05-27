import 'dart:math';

import 'package:deptechcodingtest/view/Event/controller/EventController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../utils/notificationService.dart';

class customSetReminder extends StatefulWidget {
  final EventController controller;

  customSetReminder({required this.controller});

  @override
  _customSetReminderState createState() => _customSetReminderState();
}

class _customSetReminderState extends State<customSetReminder> {

  bool _reminderEnabled = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NotificationApi.initialize(flutterLocalNotificationsPlugin);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SwitchListTile(
          title: Text("Aktifkan Pengingat"),
          value: _reminderEnabled,
          onChanged: (bool value) {
            setState(() {
              _reminderEnabled = value;
            });
          },
        ),
        if (_reminderEnabled)
          Container(
            margin: EdgeInsets.only(left: 20),
            child: DropdownButton<String>(
              value: widget.controller.selectedReminder,
              onChanged: (String? newValue) {
                setState(() {
                  widget.controller.selectedReminder = newValue!;
                });
                // Set reminder
                final notificationTime = _calculateNotificationTime(
                  widget.controller.selectedReminder,
                  widget.controller.selectedDate,
                  widget.controller.selectedTime,
                );

                if (notificationTime != null) {
                  Random random = Random();
                  int randomNumber = random.nextInt(100);

                  NotificationApi.showScheduleNotification(
                    id: randomNumber,
                    title: widget.controller.eventTitleController.text,
                    body: "Agenda ${widget.controller.eventTitleController.text} akan dimulai!",
                    scheduleTime: notificationTime,
                    fLN: flutterLocalNotificationsPlugin,
                  );
                }
              },
              items: widget.controller.reminderOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          )
      ],
    );
  }

  DateTime? _calculateNotificationTime(String reminder, DateTime selectedDate, TimeOfDay selectedTime) {
    switch (reminder) {
      case "1 hari sebelum":
        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day - 1,
          selectedTime.hour,
          selectedTime.minute,
        );
      case "3 jam sebelum":
        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour - 3,
          selectedTime.minute,
        );
      case "1 jam sebelum":
        return DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour - 1,
          selectedTime.minute,
        );
      default:
        return null;
    }
  }
}