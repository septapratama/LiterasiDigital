import 'package:flutter/material.dart';
import 'package:test123/riwayatCalendar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'this app is ass',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: RiwayatCalendar(),
    );
  }
}
