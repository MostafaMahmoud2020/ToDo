import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/screens/tasks/task_item.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';
import 'package:todo/shared/styles/my_theme_data.dart';
import '../../providers/provider.dart';
import '../../shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  int value = 0;
  bool flag = false;
  var selectedDate = DateTime.now();
  var item;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.waving_hand_outlined,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Hi, ",
                  style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary)),
              Text("${provider.userModel?.name}",
                  style: GoogleFonts.poppins(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor)),
            ],
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: CalendarTimeline(
            initialDate: selectedDate,
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
            onDateSelected: (date) {
              setState(() {
                selectedDate = date;
              });
            },
            leftMargin: 50,
            monthColor: Colors.grey,
            dayColor: Colors.grey,
            activeDayColor: Colors.white,
            activeBackgroundDayColor: primaryColor,
            dotsColor: Colors.black,
            locale: 'en',
          ),
        ),
        SizedBox(
          height: 5,
        ),

        //future -> stream
        StreamBuilder(
          stream: FirebaseFunctions.getTasks(selectedDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            }

            List<TaskModel> tasks =
                snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

            if (tasks.isEmpty) {
              return Center(
                child: Text("No Tasks",
                    style: MyThemeData.lightTheme.textTheme.bodyLarge!
                        .copyWith(color: primaryColor)),
              );
            }

            return Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) => check(tasks[index]),
                  itemCount: tasks.length),
            );
          },
        )
      ],
    );
  }

  check(TaskModel taskModel) {
    if (value == 0) {
      item = TaskItem(value, taskModel);
      value++;
      return item;
    }
    if (value != 0) {
      if (value == 4) {
        value = 0;

        item = TaskItem(value, taskModel);
        value++;
        return item;
      }

      item = TaskItem(value, taskModel);
      value++;

      return item;
    }
  }
}
