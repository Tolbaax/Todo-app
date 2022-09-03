import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/view/widgets/profile_image_widget.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          titleTextStyle: TextStyle(color: Colors.black),
          title: Text(
            "Schedule",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              letterSpacing: 1,
            ),
          ),
          actions: [
            profileImage(radius: 16),
            SizedBox(
              width: 10,
            ),
          ],
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: DatePicker(
                DateTime.now(),
                height: 90,
                width: 65,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.deepPurple.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
