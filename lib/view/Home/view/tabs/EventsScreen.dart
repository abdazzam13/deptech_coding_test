import 'package:deptechcodingtest/data/local/model/event.dart';
import 'package:deptechcodingtest/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../utils/helper.dart';
import '../../controller/HomeController.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.getEventFromDb().then((value){
      if (value != null && value.length != 0){
        setState(() {
          homeController.events = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          "assets/logo.png",
          width: 70,
          height: 70,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: homeController.events?.length != 0
              ? Expanded(
                  child: ListView.builder(
                    itemCount: homeController.events?.length,
                    itemBuilder: (context, index) =>
                        itemEvent(homeController.events![index]),
                  ),
                )
              : Center(
                  child: Text("Event List kosong"),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Color(0XFFF7BE61),
        ),
        backgroundColor: Color(0XFF3B3C8C),
        onPressed: () {
          Get.toNamed(AppRoutes.createEvent);
        },
      ),
    );
  }

  Widget itemEvent(Event event) {
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
