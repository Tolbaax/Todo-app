import 'package:flutter/material.dart';
import 'package:todo_app/model/note_model.dart';

class AppProvider extends ChangeNotifier {
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  int selectedTaskColor = 0;
  List<TaskModel> allTasks = [];
  List<TaskModel> doneTasks = [];

  changeVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    notifyListeners();
  }

  changeColor(index) {
    selectedTaskColor = index;
    notifyListeners();
  }
}
