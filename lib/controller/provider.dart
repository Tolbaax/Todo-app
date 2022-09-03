import 'package:flutter/material.dart';
import 'package:todo_app/model/menu_item_model.dart';
import 'package:todo_app/model/note_model.dart';
import 'package:todo_app/view/screens/archived/archived_screen.dart';
import 'package:todo_app/view/screens/done/done_screen.dart';
import 'package:todo_app/view/screens/home/home_screen.dart';
import 'package:todo_app/view/screens/home/task_screen.dart';

class AppProvider extends ChangeNotifier {
  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;
  MenuItemModel currentItem = MenuItems.tasks;
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

  changeItem(item) {
    currentItem = item;
    notifyListeners();
  }

  getScreen() {
    if (currentItem == MenuItems.tasks) {
      return TaskScreen();
    } else if (currentItem == MenuItems.done) {
      return DoneScreen();
    } else if (currentItem == MenuItems.archived) {
      return ArchivedScreen();
    }
  }
}
