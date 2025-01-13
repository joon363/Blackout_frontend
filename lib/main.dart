import 'package:flutter/material.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/route/route_constants.dart';
import 'package:bremen/route/router.dart' as router;
import 'package:bremen/State/state_manager.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GlobalState()),
      ],
      child: MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bremen',
      theme: AppTheme.lightTheme(context),
      onGenerateRoute: router.generateRoute,
      initialRoute: loginPageRoute,
    );
  }
}
