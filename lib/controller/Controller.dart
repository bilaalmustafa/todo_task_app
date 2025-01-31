import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo_task_app/model/task_model.dart';
import 'package:todo_task_app/view/Home_Screen.dart';

class Controller extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final RxList<TaskModel> taskList = <TaskModel>[].obs;
  final RxBool isvisible = false.obs;

  final RxBool daily = false.obs;
  final box = Hive.box<TaskModel>('TaskTable');
  var isVisibleList = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
    syncVisibilityList();
  }

  // Toggle visibility of a specific task

  void toggleVisibility(int index) {
    isVisibleList[index] = !isVisibleList[index];
  }
  // void toggleVisibility(int index) {
  //   if (index >= 0 && index < isVisibleList.length) {
  //     isVisibleList[index] = !isVisibleList[index];
  //     isVisibleList.refresh();
  //   }
  // }

  // Sync visibility list when tasks are loaded
  void syncVisibilityList() {
    isVisibleList.clear();
    isVisibleList.addAll(List.generate(taskList.length, (_) => false));
  }

  // Add a new task with daily or one-time logic
  void addTask() {
    final title = titleController.text.trim();

    if (title.isEmpty) {
      Get.snackbar('Error', 'Task title cannot be empty');
      return;
    }
    final task = TaskModel(
      title: title,
      isDaily: daily.value,
      lastComplatedDate: DateTime.now(),
    );
    taskList.add(task);
    isVisibleList.add(false);
    box.add(task);
    Get.to(() => HomeScreen(),
        transition: Transition.upToDown, duration: Duration(seconds: 2));
    Get.snackbar('Success', 'Task added successfully');
    titleController.clear();
  }

  // Toggle task completion; reset daily tasks for tomorrow
  void toggleTaskCompletion(int originalIndex) {
    if (originalIndex >= 0 && originalIndex < taskList.length) {
      taskList[originalIndex].isCompleted =
          !taskList[originalIndex].isCompleted;
      box.putAt(originalIndex, taskList[originalIndex]); // Update in Hive
      taskList.refresh();
    }
  }

  // Load tasks and filter out completed daily tasks
  void loadTasks() {
    final now = DateTime.now();
    syncVisibilityList();
    // Check each task if it's daily and was completed on a previous day, then reset it
    taskList.assignAll(box.values.map((task) {
      if (task.isDaily &&
          task.isCompleted &&
          _isDifferentDay(task.lastComplatedDate, now)) {
        return TaskModel(
          title: task.title,
          isDaily: true,
          isCompleted: false, // Reset for new day
          lastComplatedDate: now,
        );
      }
      return task;
    }).toList());

    update();
  }

  //  check if the last completed date is a different day
  bool _isDifferentDay(DateTime oldDate, DateTime newDate) {
    return oldDate.year != newDate.year ||
        oldDate.month != newDate.month ||
        oldDate.day != newDate.day;
  }

  // Delete a task permanently
  void deleteTask(int originalIndex) {
    if (originalIndex >= 0 && originalIndex < taskList.length) {
      box.deleteAt(originalIndex);
      taskList.removeAt(originalIndex);
      isVisibleList.removeAt(originalIndex);
      taskList.refresh();
    }
  }
}
