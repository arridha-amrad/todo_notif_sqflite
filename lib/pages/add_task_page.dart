import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_notif_sqflite/controllers/add_task_controller.dart';
import 'package:todo_notif_sqflite/customWidgets/my_text_field.dart';
import 'package:todo_notif_sqflite/ui/theme.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddTaskController controller = Get.put(AddTaskController());
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                MyTextField(
                  label: "Title",
                  hint: "Enter title here",
                  textcontroller: controller.titleController,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  label: "Note",
                  hint: "Enter note here",
                  textcontroller: controller.noteController,
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                  widget: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _showDatePicker(context, controller),
                  ),
                  label: "Date",
                  hint: DateFormat.yMd()
                      .format(controller.dateTime.value)
                      .toString(),
                ),
                const SizedBox(height: 16.0),
                _timeWidget(context, controller),
                const SizedBox(height: 16.0),
                MyTextField(
                  label: "Remind",
                  hint: "${controller.selectedRemindTime} minutes",
                  widget: _showDropDown(controller, true),
                ),
                const SizedBox(height: 16.0),
                MyTextField(
                    label: "Repeat",
                    hint: "${controller.selectedRepeat}",
                    widget: _showDropDown(controller, false)),
                const SizedBox(height: 16.0),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: _createTaskButton(controller),
                  title: Text(
                    "Color",
                    style: textFieldLabelStyle,
                  ),
                  subtitle: _pickColor(controller),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _createTaskButton(AddTaskController controller) {
    return ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.resolveWith(
                (states) => const EdgeInsets.all(12.0)),
            backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Color(controller.selectedColor.value))),
        onPressed: () => controller.createNewTodo(),
        child: const Text("Create Task",
            style: TextStyle(
              color: Colors.white,
            )));
  }

  Widget _pickColor(AddTaskController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: controller.taskColors.map((Color color) {
          return GestureDetector(
            onTap: () {
              controller.selectedColor.value = color.value;
              print(controller.selectedColor.value);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12.0),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0,
                  color: Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(50),
                color: color,
              ),
              child: controller.selectedColor.value == color.value
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                    )
                  : const SizedBox(
                      height: 0,
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text("Add Task"),
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

  Widget _showDropDown(AddTaskController controller, bool isRemind) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: DropdownButton(
          underline: const SizedBox(height: 0),
          elevation: 2,
          items: isRemind
              ? controller.remindList
                  .map<DropdownMenuItem<String>>(
                      (int value) => DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          ))
                  .toList()
              : controller.repeatList
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ))
                  .toList(),
          onChanged: (dynamic value) {
            isRemind
                ? controller.selectedRemindTime.value =
                    int.parse(value as String)
                : controller.selectedRepeat.value = value;
          }),
    );
  }

  Widget _timeWidget(BuildContext context, AddTaskController controller) {
    return Row(
      children: [
        Flexible(
            child: MyTextField(
          hint: controller.startTime.value,
          label: "Start Time",
          widget: IconButton(
              onPressed: () => _setTime(context, controller, true),
              icon: const Icon(
                Icons.access_time,
              )),
        )),
        const SizedBox(width: 12.0),
        Flexible(
          child: MyTextField(
            hint: controller.endTime.value,
            label: "End Time",
            widget: IconButton(
                onPressed: () => _setTime(context, controller, false),
                icon: const Icon(
                  Icons.access_time,
                )),
          ),
        ),
      ],
    );
  }

  void _setTime(BuildContext context, AddTaskController controller,
      bool isStartTime) async {
    TimeOfDay? time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time != null) {
      if (isStartTime) {
        controller.startTime.value = time.format(context);
      } else {
        controller.endTime.value = time.format(context);
      }
    }
  }

  Future _showDatePicker(
      BuildContext context, AddTaskController controller) async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2050),
    );
    if (dateTime != null) {
      controller.dateTime.value = dateTime;
    }
  }
}
