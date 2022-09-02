import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/model/menu_item_model.dart';
import 'package:todo_app/view/widgets/logout_button_widget.dart';
import 'package:todo_app/view/widgets/profile_image_widget.dart';

class MenuScreen extends StatefulWidget {
  final ValueChanged<MenuItemModel> onSelectedItem;
  final MenuItemModel currentItem;
  MenuScreen(
      {super.key, required this.onSelectedItem, required this.currentItem});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSwitched = false;
  bool isSwitched1 = false;
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var height = screenSize.height;
    var width = screenSize.width;

    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.blueGrey.shade800,
        body: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.05,
                ),
                profileImage(radius: 32, borderColor: Colors.white),
                Spacer(),
                SizedBox(
                  width: width * 0.37,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mohamed Tolba',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: height * 0.017,
                      ),
                      Text(
                        'Active Status',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.06,
            ),
            ...MenuItems.all.map(buildMenuItem).toList(),
            SizedBox(
              height: height * 0.04,
            ),
            Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: Switch(
                value: isSwitched,
                onChanged: notifySwitch,
              ),
            ),
            ListTile(
              title: Text(
                'Dark Theme',
                style: TextStyle(fontSize: 18.0),
              ),
              trailing: Switch(
                value: isSwitched1,
                onChanged: darkSwitch,
              ),
            ),
            Spacer(),
            LogOutButton(context),
            SizedBox(
              height: height * 0.09,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem(MenuItemModel item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selected: widget.currentItem == item,
        selectedTileColor: Colors.black26,
        leading: Icon(item.icon, color: Colors.grey.shade400),
        title: Text(item.title.toString(), style: TextStyle(fontSize: 18)),
        onTap: () => widget.onSelectedItem(item),
      ),
    );
  }

  void notifySwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void darkSwitch(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
    } else {
      setState(() {
        isSwitched1 = false;
      });
    }
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
