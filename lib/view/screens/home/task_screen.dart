import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/controller/store.dart';
import 'package:todo_app/model/note_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/screens/add_task/add_task_screen.dart';
import 'package:todo_app/view/screens/schedule/schedule_screen.dart';
import 'package:todo_app/view/widgets/no_notes_widget.dart';
import 'package:todo_app/view/widgets/note_widget.dart';
import 'package:todo_app/view/widgets/profile_image_widget.dart';

class TaskScreen extends StatelessWidget {
  static const colorizeColors = [
    Colors.black,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  Store store = Store();
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            ZoomDrawer.of(context)?.toggle();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, ScheduleScreen());
            },
            icon: Icon(Icons.calendar_month),
          ),
          SizedBox(
            width: 10,
          ),
          profileImage(radius: 16),
          SizedBox(
            width: 10,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          navigateTo(context, AddTaskScreen());
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: store.getAllTasks(),
        builder: (context, AsyncSnapshot snapShot) {
          // checking the connection state;
          if (snapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          List<TaskModel> tasks = [];
          for (DocumentSnapshot doc in snapShot.data!.docs) {
            Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
            tasks.add(
              TaskModel(
                title: json['title'],
                note: json['note'],
                deadLine: json['deadLine'],
                startTime: json['startTime'],
                endTime: json['endTime'],
                colorId: json['colorId'],
              ),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.009),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 25.0,
                  end: 25.0,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedTextKit(
                          animatedTexts: [
                            ColorizeAnimatedText(
                              "What\'s up, Mohamed!",
                              textStyle: TextStyle(fontSize: 20.0),
                              colors: colorizeColors,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.008,
                        ),
                        Text(
                          '${tasks.length} task pending',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrange.shade900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.017,
              ),
              snapShot.hasData && !tasks.isEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return buildTaskItem(
                              height, width, tasks, index, snapShot);
                        },
                      ),
                    )
                  : noNotesWidget(context),
            ],
          );
        },
      ),
    );
  }
}
