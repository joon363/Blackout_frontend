import 'package:flutter/material.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/route/route_constants.dart';
import 'package:bremen/route/router.dart' as router;
import 'package:bremen/Connection/state_manager.dart';

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

  // This widget is the root of your application.
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
