import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_notif_sqflite/controllers/home_controller.dart';
import 'package:todo_notif_sqflite/database/todo/todo_database.dart';
import 'package:todo_notif_sqflite/models/todo_model.dart';

class AddTaskController extends GetxController {
  HomeController homeController = Get.find<HomeController>();

  late TextEditingController titleController;
  late TextEditingController noteController;
  var dateTime = DateTime.now().obs;
  var startTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;
  var endTime = DateFormat("hh:mm a").format(DateTime.now()).toString().obs;

  List<int> remindList = [5, 10, 15, 20];
  List<String> repeatList = ["None", "Weekly", "Monthly", "Yearly"];
  var selectedRemindTime = 0.obs;
  var selectedRepeat = "".obs;

  List<Color> taskColors = [Colors.red, Colors.orange, Colors.green];
  var selectedColor = 0.obs;

  Future createNewTodo() async {
    final todo = Todo(
      isComplete: false,
      title: titleController.text,
      note: noteController.text,
      date: dateTime.value,
      startTime: startTime.value,
      endTime: endTime.value,
      remind: selectedRemindTime.value,
      repeat: selectedRepeat.value,
      color: selectedColor.value,
    );
    final newTodo = await TodoDatabase.instance.createTodo(todo);
    homeController.todos.add(newTodo);
    Get.back();
  }

  @override
  void onInit() {
    titleController = TextEditingController();
    noteController = TextEditingController();
    selectedRemindTime.value = remindList.first;
    selectedRepeat.value = repeatList.first;
    selectedColor.value = taskColors.last.value;
    super.onInit();
  }

  @override
  void onClose() {
    titleController.dispose();
    noteController.dispose();
    super.onClose();
  }
}
