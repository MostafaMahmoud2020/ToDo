import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo/screens/edit/edit_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/shared/styles/colors.dart';
import 'package:todo/shared/styles/my_theme_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/shared/firebase/firebase_functions.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;
  int index;

  TaskItem(this.index, this.taskModel);

  List<String> images = [
    "assets/images/5dbc2410-7547-4c7e-ab1d-6a0443c3c1bf-removebg-preview.png",
    "assets/images/Apple_Memoji__1_-removebg-preview.png",
    "assets/images/iPhone_Memoji-removebg-preview.png",
    "assets/images/Memoji_Chico_Con_Mascarilla__1_-removebg-preview.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3),
      child: Container(
          height: MediaQuery.of(context).size.height * .26,
          //alignment: AlignmentDirectional.center,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  images[index],
                  scale: 4.3,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Slidable(
                    startActionPane: ActionPane(
                        extentRatio: 0.3,
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              FirebaseFunctions.deleteTask(taskModel.id);

                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.success(
                                  backgroundColor: primaryColor,
                                  message: "Task Deleted Successfully!",
                                ),
                              );
                            },
                            backgroundColor: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ]),
                    endActionPane: ActionPane(
                        extentRatio: .3,
                        motion: BehindMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {
                              Navigator.pushNamed(context, EditScreen.routeName,
                                  arguments: {
                                    "title": taskModel.title,
                                    "description": taskModel.description,
                                    "taskModel": taskModel
                                  });
                            },
                            backgroundColor: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18.0, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(20),
                            width: 3,
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColor),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " ${taskModel.title}",
                                style: MyThemeData
                                    .lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${taskModel.description}",
                                style: MyThemeData
                                    .lightTheme.textTheme.bodySmall
                                    ?.copyWith(
                                        fontSize: 15,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary),
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              taskModel.isDone = true;
                              FirebaseFunctions.updateTask(taskModel);
                            },
                            child: taskModel.isDone
                                ? CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: Text("Done !",
                                        style: MyThemeData
                                            .lightTheme.textTheme.bodySmall!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 10)),
                                  )
                                : CircleAvatar(
                                    backgroundColor: primaryColor,
                                    child: Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
