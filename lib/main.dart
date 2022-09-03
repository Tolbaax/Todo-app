import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/provider.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/shared/components/constant.dart';
import 'package:todo_app/shared/network/local/cache_helper.dart';
import 'package:todo_app/view/screens/home/home_screen.dart';
import 'package:todo_app/view/screens/login/login_screen.dart';

void main() async {
  // make sure that everything in methode is finished, then open the app
  WidgetsFlutterBinding.ensureInitialized();
  final Widget startWidget;
  await CacheHelper.init();
  loggedBy = CacheHelper.getData(key: 'loggedBy');
  // use shared preferences to open app in right screen only
  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    startWidget = HomeScreen();
  } else {
    startWidget = LoginScreen();
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppProvider()),
      ],
      child: Todo(
        startWidget: startWidget,
      ),
    ),
  );
}

class Todo extends StatelessWidget {
  Widget? startWidget;
  Todo({Key? key, this.startWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startWidget,
    );
  }
}
