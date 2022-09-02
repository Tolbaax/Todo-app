import 'package:flutter/material.dart';
import 'package:todo_app/controller/auth.dart';
import 'package:todo_app/shared/components/components.dart';
import 'package:todo_app/view/screens/login_screen.dart';

Widget LogOutButton(context) {
  Auth auth = Auth();
  return GestureDetector(
    onTap: () {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Log Out',
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              'Are you sure want to exit?',
              style: TextStyle(color: Colors.grey.shade400),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  auth.signOut();
                  navigateAndRemoveUntil(context, LoginScreen());
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            backgroundColor: Colors.blueGrey.shade700,
          );
        },
      );
    },
    child: ListTile(
      leading: Icon(
        Icons.logout,
        color: Colors.grey.shade400,
      ),
      title: Text(
        'Log Out',
        style: TextStyle(color: Colors.grey.shade300, fontSize: 20),
      ),
    ),
  );
}
