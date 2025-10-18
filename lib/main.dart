import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/timer_controller.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/timer_page.dart';
import 'pages/history_page.dart';

void main() {
  Get.put(TimerController());
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData _lightTheme() => ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.pinkAccent,
        scaffoldBackgroundColor: const Color(0xFFFDF3F6),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.pinkAccent),
      );

  ThemeData _darkTheme() => ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrangeAccent,
        scaffoldBackgroundColor: Colors.grey[900],
        appBarTheme: AppBarTheme(backgroundColor: Colors.pink.shade700),
      );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      theme: _lightTheme(),
      darkTheme: _darkTheme(),
      themeMode: ThemeMode.light,
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/timer', page: () => const TimerPage()),
        GetPage(name: '/history', page: () => const HistoryPage()),
      ],
    );
  }
}
