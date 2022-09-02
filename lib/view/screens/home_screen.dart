import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/model/menu_item_model.dart';
import 'package:todo_app/view/screens/archived_screen.dart';
import 'package:todo_app/view/screens/done_screen.dart';
import 'package:todo_app/view/screens/note_screen.dart';

import 'menu_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  isSigned() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool('sign', true);
  }

  ZoomDrawerController zoomDrawerController = ZoomDrawerController();
  MenuItemModel currentItem = MenuItems.tasks;
  @override
  void initState() {
    super.initState();
    isSigned();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        body: ZoomDrawer(
          controller: zoomDrawerController,
          mainScreen: getScreen(),
          menuScreen: Builder(
            builder: (context) => MenuScreen(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() {
                  currentItem = item;
                });

                ZoomDrawer.of(context)!.close();
              },
            ),
          ),
          angle: 0.0,
          showShadow: true,
          menuScreenWidth: width * 0.62,
        ),
      ),
    );
  }

  getScreen() {
    if (currentItem == MenuItems.tasks) {
      return NoteScreen();
    } else if (currentItem == MenuItems.done) {
      return DoneScreen();
    } else if (currentItem == MenuItems.archived) {
      return ArchivedScreen();
    }
  }
}
