import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:todo/models/user_model.dart';
import 'package:todo/screens/settings/settings_tab.dart';
import 'package:todo/screens/tasks/tasks_tab.dart';
import 'package:todo/shared/components/appbar.dart';
import '../providers/provider.dart';
import 'package:animate_gradient/animate_gradient.dart';
import '../screens/tasks/showTasksBottomSheet.dart';
import '../shared/styles/colors.dart';

class HomeLayout extends StatefulWidget {
  HomeLayout({super.key});

  static const String routeName = "HomeLayout";

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  Color bottomColor = primaryColor;

  Alignment begin = Alignment.bottomLeft;
  Alignment end = Alignment.topRight;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    Color topColor =
        provider.modeApp == ThemeMode.light ? Colors.white : blackColor;
    Color centerColor =
        provider.modeApp == ThemeMode.light ? Colors.white : blackColor;
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: begin,
              end: end,
              colors: [bottomColor, centerColor, topColor])),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            extendBody: true,
            backgroundColor: Colors.transparent,
            appBar: SharedAppbar(),
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
              child: BottomAppBar(
                color: Theme.of(context).colorScheme.primary,
                shape: CircularNotchedRectangle(),
                notchMargin: 8,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  child: BottomNavigationBar(
                    onTap: (int value) => provider.changeBody(value),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: provider.index,
                    items: const [
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.list,
                            size: 30,
                          ),
                          label: ""),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.settings,
                            size: 30,
                          ),
                          label: ""),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  showSheet();
                },
                child: Icon(Icons.add,
                    color: Theme.of(context).colorScheme.primary, size: 30),
                shape: CircleBorder(
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3))),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: tabs[provider.index],
          ),
        ],
      ),
    );
  }

  showSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          side: BorderSide(color: Colors.transparent)),
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: showTasksBottomSheet(),
        );
      },
    );
  }

  List<Widget> tabs = [TasksTab(), SettingsTab()];
}
