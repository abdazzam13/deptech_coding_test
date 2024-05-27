import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/local/model/event.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import '../../utils/helper.dart';
class itemEvent extends StatelessWidget {
  const itemEvent({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.toNamed(AppRoutes.eventDetail, arguments: {"event" : event});
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0XFF3B3C8C),
          ),
          color: Color(0XFF3B3C8C),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text(
                  "${event.date?.split(" ")[0]}",
                  style: TextStyle(
                      color: Color(0XFF60D669), fontWeight: FontWeight.bold),
                ),
                Text(
                  "${event.date?.split(" ")[1]}",
                  style: TextStyle(
                      color: Color(0XFF60D669),
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "${event.title}",
                  style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  Helper().cutString("${event.desc}"),
                  style: TextStyle(color: Colors.white),
                )
              ],
            ),
            Icon(
              event.reminderTime != null
                  ? Icons.notifications_active
                  : Icons.notifications_off,
              color: event.reminderTime != null ? Color(0XFFF7BE61) : Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}