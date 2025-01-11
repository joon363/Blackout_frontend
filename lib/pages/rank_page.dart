import 'package:bremen/themes.dart';
import 'package:bremen/pages/components.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';


class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('First Screen')),
        body: Container(
          width: 100,
          height: 100,
          color: Colors.black,
        )
    );
  }
}