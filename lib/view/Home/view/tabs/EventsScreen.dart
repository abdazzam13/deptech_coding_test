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
            child: Column(
          children: [
            itemEvent("24", "MEI", "Nobar Haikyuu", "Event ini diselenggarakan di CGV Grand Indonesia pada tanggal 24 Mei 2024 pukul 17.00", true),
            itemEvent("24", "MEI", "Nobar Haikyuu", "Event ini diselenggarakan di CGV Grand Indonesia pada tanggal 24 Mei 2024 pukul 17.00", false),
            itemEvent("24", "MEI", "Nobar Haikyuu", "Event ini diselenggarakan di CGV Grand Indonesia pada tanggal 24 Mei 2024 pukul 17.00", true),
            itemEvent("24", "MEI", "Nobar Haikyuu", "Event ini diselenggarakan di CGV Grand Indonesia pada tanggal 24 Mei 2024 pukul 17.00", false)
          ],
        )),
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

  Widget itemEvent(String date, String month, String title, String desc, bool isNotificationOn){
    return Container(
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
                date,
                style: TextStyle(
                    color: Color(0XFF60D669),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                month,
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
                title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                Helper().cutString(
                    desc),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
          Icon(
            isNotificationOn ? Icons.notifications_active : Icons.notifications_off,
            color: isNotificationOn ? Color(0XFFF7BE61): Colors.red,
          ),
        ],
      ),
    );
  }
}
