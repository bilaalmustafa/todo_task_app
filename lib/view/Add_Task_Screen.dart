import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_task_app/controller/Controller.dart';
import 'package:todo_task_app/res/Colors.dart';
import 'package:todo_task_app/view/Home_Screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final Controller controller = Get.put(Controller());
    return Scaffold(
      backgroundColor: AppColors.seconderyColor,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          height: Get.height * 0.8,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Get.to(() => HomeScreen(),
                          transition: Transition.upToDown),
                      icon: Icon(
                        Icons.close,
                        size: 40,
                        color: AppColors.greyColor,
                      ),
                    ),
                    Text(
                      "Add Task",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor),
                    ),
                    SizedBox(
                      width: 40,
                    )
                  ],
                ),
              ),
              Divider(
                color: AppColors.dividerColor,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Task title',
                    hintStyle: TextStyle(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500),
                    filled: true,
                    fillColor: AppColors.greyshadow,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.greyshadow,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.seconderyColor, width: 2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Divider(
                color: AppColors.dividerColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To every day",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor),
                      ),
                      Switch(
                          inactiveTrackColor: AppColors.primaryColor,
                          trackOutlineColor:
                              WidgetStateProperty.all(AppColors.seconderyColor),
                          thumbColor:
                              WidgetStateProperty.all(AppColors.seconderyColor),
                          activeColor: AppColors.primaryColor,
                          value: controller.daily.value,
                          onChanged: (vlue) {
                            controller.daily.value = vlue;
                          }),
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.dividerColor,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "To todays list only",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: AppColors.greyColor),
                      ),
                      Switch(
                          inactiveTrackColor: AppColors.primaryColor,
                          trackOutlineColor:
                              WidgetStateProperty.all(AppColors.seconderyColor),
                          thumbColor:
                              WidgetStateProperty.all(AppColors.seconderyColor),
                          activeColor: AppColors.primaryColor,
                          value: !controller.daily.value,
                          onChanged: (vlue) {
                            controller.daily.value = !vlue;
                          }),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      style: ButtonStyle(
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.seconderyColor),
                        minimumSize: WidgetStateProperty.all(Size(110, 40)),
                      ),
                      onPressed: () {
                        controller.addTask();
                      },
                      child: Text(
                        "Save Task",
                        style: TextStyle(color: AppColors.primaryColor),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
