import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/provider.dart';
import 'package:todo_app/model/menu_item_model.dart';
import 'package:todo_app/view/screens/menu/menu_screen.dart';

class HomeScreen extends StatelessWidget {
  ZoomDrawerController zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        body: ZoomDrawer(
          controller: zoomDrawerController,
          mainScreen: provider.getScreen(),
          menuScreen: Builder(
            builder: (context) => MenuScreen(
              currentItem: provider.currentItem,
              onSelectedItem: (item) {
                provider.changeItem(item);
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
}

class MenuItems {
  static final tasks = MenuItemModel('Tasks', Icons.task_outlined);
  static final archived = MenuItemModel('Archived', Icons.archive_outlined);
  static final done = MenuItemModel('Done', Icons.task_alt_outlined);

  static final all = <MenuItemModel>[
    tasks,
    archived,
    done,
  ];
}
