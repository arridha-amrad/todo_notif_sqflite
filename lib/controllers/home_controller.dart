import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_notif_sqflite/database/todo/todo_database.dart';
import 'package:todo_notif_sqflite/models/todo_model.dart';
import 'package:todo_notif_sqflite/services/notification_service.dart';

class HomeController extends GetxController {
  final isDarkMode = false.obs;
  final selectedDate = DateTime.now().obs;
  late GetStorage box;
  final key = "isDarkMode";
  late NotificationHelper notifyHelper;

  final todos = <Todo>[].obs;

  Future fetchTodosFromDB() async {
    final todos = await TodoDatabase.instance.getTodos();
    todos.addAll(todos);
  }

  @override
  void onInit() {
    box = GetStorage();
    isDarkMode.value = box.read(key) ?? false;
    notifyHelper = NotificationHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermission();

    fetchTodosFromDB();
    super.onInit();
  }
}
