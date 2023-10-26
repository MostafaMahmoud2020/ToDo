import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/layout/home_layout.dart';
import 'package:todo/providers/provider.dart';
import 'package:todo/screens/login/login_screen.dart';

import 'package:todo/screens/settings/showThemeSheet.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:todo/shared/styles/my_theme_data.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<MyProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Apperance",
              style: MyThemeData.lightTheme.textTheme.bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
          SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: showBottomSheetAppearance,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(pro.modeApp == ThemeMode.light ? "Light" : "Dark",
                        style: MyThemeData.lightTheme.textTheme.bodySmall
                            ?.copyWith(fontSize: 20, color: Colors.white)),
                    Icon(
                      Icons.arrow_drop_down_sharp,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeLayout.routeName, (route) => false);
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.routeName, (route) => false);
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: primaryColor,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Log out",
                        style: MyThemeData.lightTheme.textTheme.bodySmall
                            ?.copyWith(fontSize: 20, color: Colors.white)),
                    SizedBox(
                      width: 15,
                    ),
                    Icon(
                      Icons.login_outlined,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showBottomSheetAppearance() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      builder: (context) {
        return ShowThemeSheet();
      },
    );
  }
}
