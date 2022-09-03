import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/view/screens/home/home_screen.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

//====================================================================

Future navigateAndRemoveUntil(context, widget) {
  return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false);
}
//====================================================================

void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 17.0,
    );

// enum
enum ToastState { success, error }

Color? chooseToastColor(ToastState state) {
  Color? color;

  switch (state) {
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      break;
  }

  switch (state) {
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.success:
      break;
  }

  return color;
}

//===============================================================
String? validateEmail(String? value) {
  if (value!.isEmpty) {
    return 'Please Enter Your Email';
  }
  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Invalid E-mail Address format';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Please Enter Your Password';
  }
  if (value.length < 8) {
    return 'Password must have at least 8 characters';
  }
  return null;
}

void validateLogin(formKey, auth, email, password, context) async {
  // inAsyncCall => True
  if (formKey.currentState!.validate()) {
    formKey.currentState!.save();

    try {
      await auth.signIn(email.toString(), password.toString());

      // inAsyncCall => False
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));

      showToast(
        text: 'Login Successfully',
        state: ToastState.success,
      );
    } on FirebaseAuthException catch (error) {
      print(error);
      if (error.code == 'wrong-password') {
        showToast(
          text: 'Incorrect Password',
          state: ToastState.error,
        );
      } else if (error.code == 'user-not-found') {
        showToast(text: 'User not found', state: ToastState.error);
      }
    }
  }
}

String? facebookException(e, title) {
  switch (e.code) {
    case 'account-exists-with-different-credential':
      title = 'This account exists with a different sign in provider';
      break;
    case 'invalid-credential':
      title = 'Unknown error has occurred';
      break;
    case 'operation-not-allowed':
      title = 'This operation not allowed';
      break;
    case 'user-disabled':
      title = 'The user you tried to log into is disabled';
      break;
    case 'user-not-found':
      title = 'The user you tried to log into was not found';
      break;
  }
  return null;
}

//===============================================================
