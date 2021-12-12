import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_notif_sqflite/controllers/home_controller.dart';
import 'package:todo_notif_sqflite/customWidgets/my_button.dart';
import 'package:todo_notif_sqflite/models/todo_model.dart';
import 'package:todo_notif_sqflite/pages/add_task_page.dart';
import 'package:todo_notif_sqflite/ui/theme.dart';
import 'package:todo_notif_sqflite/ui/theme_services.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      appBar: _appBar(controller),
      body: SingleChildScrollView(
        child: Obx(() {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                _addTask(),
                _datePicker(context, controller),
                ...controller.todos
                    .map((Todo todo) => GestureDetector(
                          onTap: () => print(todo.id),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8.0),
                            decoration: BoxDecoration(
                                color: Color(todo.color),
                                borderRadius: BorderRadius.circular(20)),
                            child: ListTile(
                              title: Text(todo.title),
                              subtitle: Text(todo.note),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _datePicker(BuildContext context, HomeController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        deactivatedColor: Colors.grey,
        selectedTextColor: Colors.black,
        selectionColor: Colors.grey,
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          color: Colors.grey,
        )),
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        )),
        onDateChange: (DateTime date) {
          controller.selectedDate.value = date;
        },
      ),
    );
  }

  Widget _addTask() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()).toString(),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () => Get.to(() => const AddTaskPage()))
        ],
      ),
    );
  }

  AppBar _appBar(HomeController controller) {
    return AppBar(
      elevation: 0.0,
      title: const Text("Home Page"),
      leading: IconButton(
        onPressed: () {
          ThemeServices().switchTheme();
          // controller.notifyHelper.displayNotification(
          //   title: "Theme Changed",
          //   body: Get.isDarkMode
          //       ? "You switch to light mode"
          //       : "You switch to dark  mode",
          // );
          // controller.notifyHelper.scheduledNotification();
        },
        icon: Obx(() {
          return Icon(
            controller.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
          );
        }),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 12.0),
          child: CircleAvatar(
            child: Text("A"),
          ),
        )
      ],
    );
  }
}
