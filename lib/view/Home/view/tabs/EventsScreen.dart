import 'package:deptechcodingtest/data/local/model/event.dart';
import 'package:deptechcodingtest/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/helper.dart';
import '../../../component/itemEvent.dart';
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
    homeController.getEventFromDb().then((value) {
      if (value != null && value.length != 0) {
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
                        itemEvent(event: homeController.events![index]),
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
}
