import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/provider.dart';
import 'package:todo_app/controller/store.dart';
import 'package:todo_app/model/note_model.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/widgets/custom_button_widget.dart';
import 'package:todo_app/view/widgets/default_form_filed_widget.dart';
import 'package:todo_app/view/widgets/profile_image_widget.dart';

class AddTaskScreen extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  TextEditingController deadLineController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? title, note, deadLine, startTime, endTime;
  DateTime dateTime = DateTime.now();

  Store store = Store();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
          ),
          titleTextStyle: TextStyle(color: Colors.black),
          title: Text(
            'Add Task',
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
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
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: SizedBox(
                    height: height * 0.85,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        addTaskFormFiled(
                          controller: titleController,
                          title: 'Title',
                          hint: 'Enter Title Here',
                          height: height,
                          onSaved: (value) {
                            title = value;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter title';
                            }
                          },
                        ),
                        addTaskFormFiled(
                          controller: noteController,
                          title: 'Note',
                          hint: 'Enter Note Here',
                          height: height,
                          onSaved: (value) {
                            note = value;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter note';
                            }
                          },
                        ),
                        addTaskFormFiled(
                          controller: deadLineController,
                          title: 'DeadLine',
                          height: height,
                          hint: '${DateFormat.yMMMd().format(dateTime)}',
                          type: TextInputType.none,
                          suffix: Icons.date_range_outlined,
                          onSaved: (value) {
                            deadLine = value;
                          },
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter deadLine';
                            }
                          },
                          onTap: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2030))
                                .then((value) {
                              deadLineController.text =
                                  DateFormat.yMMMd().format(value!);
                            });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width / 2.4,
                              child: addTaskFormFiled(
                                controller: startTimeController,
                                title: 'Start Time',
                                height: height,
                                hint:
                                    '${TimeOfDay.now().format(context).toString()}',
                                suffix: Icons.access_time,
                                type: TextInputType.none,
                                onSaved: (value) {
                                  startTime = value;
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter time';
                                  }
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    startTimeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: width / 2.4,
                              child: addTaskFormFiled(
                                controller: endTimeController,
                                title: 'End Time',
                                height: height,
                                hint: '12:30 PM',
                                suffix: Icons.access_time,
                                type: TextInputType.none,
                                onSaved: (value) {
                                  endTime = value;
                                },
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter time';
                                  }
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    endTimeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Color',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Wrap(
                              children: List<Widget>.generate(
                                  5,
                                  (index) => Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            provider.changeColor(index);
                                          },
                                          child: CircleAvatar(
                                            radius: 15,
                                            backgroundColor:
                                                selectedColor(index),
                                            child: provider.selectedTaskColor ==
                                                    index
                                                ? Icon(
                                                    Icons.done,
                                                    color: Colors.white,
                                                  )
                                                : Container(),
                                          ),
                                        ),
                                      )),
                            ),
                          ],
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                formKey.currentState!.save();
                                await store.addNote(
                                  taskModel: TaskModel(
                                    title: title,
                                    note: note,
                                    deadLine: deadLine,
                                    startTime: startTime,
                                    endTime: endTime,
                                    colorId: provider.selectedTaskColor,
                                  ),
                                );
                                Navigator.pop(context);
                                showToast(
                                  text: '${title} Created',
                                  state: ToastState.success,
                                );
                              } catch (error) {
                                print(error);
                                Navigator.pop(context);
                              }
                            }
                          },
                          child: customButton(
                              screenSize: screenSize, text: 'Create a Task'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Color selectedColor(index) {
  return index == 0
      ? Colors.deepPurple.shade300
      : index == 1
          ? Colors.red.shade300
          : index == 2
              ? Colors.green.shade300
              : index == 3
                  ? Colors.blue.shade300
                  : Colors.blueGrey.shade300;
}
