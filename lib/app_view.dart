import 'package:flutter/material.dart';

import 'screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Money Manager",
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade500,
          onBackground: Colors.black87,
          primary: const Color.fromARGB(255, 24, 57, 54),
          secondary: Color.fromARGB(255, 10, 49, 59),
          tertiary: Color.fromARGB(255, 41, 43, 45)
        )
      ),
      home: HomeScreen(),
    );
  }
}