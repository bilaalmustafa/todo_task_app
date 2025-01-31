import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/controller/Controller.dart';
import 'package:todo_task_app/model/task_model.dart';
import 'package:todo_task_app/res/Colors.dart';
import 'package:todo_task_app/view/Add_Task_Screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Controller controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 30),
          child: Obx(() {
            // to assign incomplated and complated task
            final incompleteTasks =
                controller.taskList.where((task) => !task.isCompleted).toList();
            final completedTasks =
                controller.taskList.where((task) => task.isCompleted).toList();
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.seconderyColor),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Tasks",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  buildListView(incompleteTasks, false),
                  Text(
                    "Completed",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor),
                  ),
                  buildListView(completedTasks, true),
                ],
              ),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(
            () => AddTaskScreen(),
            transition: Transition.downToUp,
          );
        },
        backgroundColor: AppColors.seconderyColor,
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          size: 40,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget buildListView(List<TaskModel> tasks, bool complated) {
    if (tasks.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 30),
        child: Center(
          child: Text(
            complated ? "No completed tasks" : "No tasks added",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 30),
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            // Find the original index in taskList
            final originalIndex = controller.taskList.indexOf(task);

            if (originalIndex == -1) return SizedBox.shrink(); // Safety check
            return GestureDetector(
              onTap: () {
                log("Homee$originalIndex");
                // controller.isvisible.value = !controller.isvisible.value;
                // controller.toggleVisibility(originalIndex);
                controller.toggleVisibility(originalIndex);
              },
              child: Card(
                  color: Colors.grey.shade100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                  child: Obx(
                    () => Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          complated
                              ? Icons.radio_button_checked_outlined
                              : Icons.radio_button_off_outlined,
                          color: AppColors.seconderyColor,
                          size: 25,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          task.title,
                          style: TextStyle(
                              decoration: complated
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              fontSize: 13,
                              color: AppColors.blackColor),
                        ),
                        Spacer(),
                        if (!controller.isVisibleList[originalIndex])
                          SizedBox(
                            width: 30,
                            height: 50,
                            child: Icon(
                              Icons.more_vert,
                              color: AppColors.blackColor,
                              size: 18,
                            ),
                          )
                        else
                          AnimatedOpacity(
                            duration: Duration(seconds: 8),
                            opacity: controller.isVisibleList[originalIndex]
                                ? 1.0
                                : 0.0,
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColors.redShadow,
                                      borderRadius: complated
                                          ? BorderRadius.horizontal(
                                              right: Radius.circular(8))
                                          : null),
                                  child: GestureDetector(
                                    onTap: () =>
                                        controller.deleteTask(originalIndex),
                                    child: Icon(
                                      Icons.delete_outline,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                ),
                                if (!complated)
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: AppColors.geenShadow,
                                        borderRadius: BorderRadius.horizontal(
                                            right: Radius.circular(8))),
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .toggleTaskCompletion(originalIndex),
                                      child: Icon(
                                        Icons.check_sharp,
                                        color: AppColors.seconderyColor,
                                      ),
                                    ),
                                  )
                                else
                                  SizedBox(),
                              ],
                            ),
                          )
                      ],
                    ),
                  )),
            );
          }),
    );
  }
}
