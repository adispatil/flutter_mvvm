import 'package:flutter/material.dart';
import 'package:mvvm_demo/presentation/resources/routes_manager.dart';
import 'package:mvvm_demo/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal(); // private named constructor

  static const MyApp instance = MyApp._internal(); // singe instance

  factory MyApp() => instance; // factory for the class instance

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
