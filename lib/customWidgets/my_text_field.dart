import 'package:flutter/material.dart';
import 'package:todo_notif_sqflite/ui/theme.dart';

class MyTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? textcontroller;
  final Widget? widget;
  const MyTextField({
    Key? key,
    required this.label,
    required this.hint,
    this.textcontroller,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textFieldLabelStyle,
        ),
        const SizedBox(height: 12.0),
        TextField(
          readOnly: widget == null ? false : true,
          controller: textcontroller,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
              suffixIcon: widget ?? const SizedBox(),
              focusColor: Colors.grey,
              isDense: true,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              )),
        ),
      ],
    );
  }
}
