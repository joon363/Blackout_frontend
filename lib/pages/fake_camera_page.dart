import 'dart:convert';

import 'package:bremen/route/route_constants.dart';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/classes.dart';
import 'package:bremen/Connection/API_manager.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:video_player/video_player.dart';

import 'package:http/http.dart' as http;


class FakeCameraPage extends StatefulWidget {
  /// Default Constructor
  const FakeCameraPage({super.key});
  @override
  State<FakeCameraPage> createState() => _FakeCameraPageState();
}

class _FakeCameraPageState extends State<FakeCameraPage> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset("assets/videos/test_video.mp4")
      ..initialize();
    controller.play();
    Future.delayed(Duration(seconds: 10), () async {
      WidgetsFlutterBinding.ensureInitialized();
      List<CameraDescription> cameras = await availableCameras();
      Navigator.pushReplacementNamed(
          context,
          //TODO: this is fake
          // cameraPageRoute,
          fakeCameraPageRoute,
          arguments: cameras
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
      },
      child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller)
      ),
    );
  }

}
