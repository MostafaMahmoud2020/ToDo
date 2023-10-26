import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/screens/edit/edit_screen.dart';
import 'package:todo/screens/login/login_screen.dart';
import 'package:todo/shared/styles/my_theme_data.dart';

import 'firebase_options.dart';
import 'providers/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
      ChangeNotifierProvider(create: (context) => MyProvider(), child: todo()));
}

class todo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: provider.modeApp,
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      routes: {
        HomeLayout.routeName: (context) => HomeLayout(),
        EditScreen.routeName: (context) => EditScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      initialRoute: provider.firebaseUser != null
          ? HomeLayout.routeName
          : LoginScreen.routeName,
    );
  }
}
