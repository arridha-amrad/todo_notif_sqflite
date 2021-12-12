import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_notif_sqflite/controllers/home_controller.dart';

class MyButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const MyButton({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: controller.isDarkMode.value
                        ? Colors.black
                        : Colors.white,
                  )),
        ),
      ),
    );
  }
}
