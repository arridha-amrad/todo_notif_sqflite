import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todo_notif_sqflite/ui/theme.dart';
import 'package:todo_notif_sqflite/ui/theme_services.dart';

import 'pages/home_page.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      themeMode: ThemeServices().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,
    );
  }
}
