import 'package:bremen/route/route_constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/classes.dart';

import 'package:http/http.dart' as http;


const dummyResponse = {
  "score": 98.5,
  "frame_id": 1234567890,
  "road_outline": {
    "bottom_x_r": 0.5,
    "bottom_x_s": 0.6,
    "bottom_y": 1.0,
    "top_x_r": 0.7,
    "top_x_s": 0.8,
    "top_y": 1.5
  },
  "coins": [
    {"x": 1.0, "y": 2.0, "r": 0.3},
    {"x": 1.5, "y": 2.5, "r": 0.4}
  ]
};

class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  bool isPolling = false;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          }
        );
      }
    ).catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
              // Handle other errors here.
              break;
            }
          }
        }
      );
  }

  @override
  void dispose() {
    isPolling = false;
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Future<double> uploadImage(BuildContext context, String imagePath) async {
      try {
        // final uri = Uri.parse("http://10.0.2.2/upload"); // 서버 URL
        // final request = http.MultipartRequest('POST', uri);
        // // 파일 추가
        // request.files.add(
        //   await http.MultipartFile.fromPath('file', imagePath),
        // );
        // // 요청 전송
        // final response = await request.send();
        // final statusCode = response.statusCode;
        if (true) {
          Future.delayed(Duration(milliseconds: 50));
          print("image uploaded");
          //final data = jsonDecode(response.body);
          final data = RoadData.fromJson(dummyResponse);
          return data.score;
        }
        else {
          //print("image upload fail: ${response.statusCode}");
          return 0.0;
        }
      }
      catch (e) {
        print("image upload error: ${e}");
        return 0.0;
      }
    }

    Future<void> screenshot(BuildContext context) async {
        try {
          if (!context.mounted) return;
          final image = await controller.takePicture();
          print("screenshot!!!!!!!!!");
          uploadImage(context,image.path);
        } catch (e) {
          print("error while screenshot: $e");
        }
    }


    Future<void> pollData(BuildContext context) async {
      if(!isPolling){
        isPolling = true;
        Timer timer = Timer.periodic(Duration(seconds: 3), (timer) async {
          print("fuck");
          await screenshot(context);
        });
      }
    }


    if (!controller.value.isInitialized) {
      return Container();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      pollData(context);
    });
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Transform.scale(
            alignment: Alignment.center,
            scaleY: 2,
            child: RotatedBox(
              quarterTurns: 1,
              child: CameraPreview(controller),
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(defaultPadding),
              child: Container(
                height: 80,
                width: 200,
                decoration: primaryBox,
                alignment: Alignment.center,
                child: Material(
                  elevation: 0,
                  color: primaryColor, // 배경색
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  child: InkWell(
                    //highlightColor: primaryColor,
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        parkLoadingPageRoute,
                      );
                    },
                    child: Container(
                      height: 80,
                      width: 200,
                      alignment: Alignment.center,
                      child: PText("주행 종료", PFontStyle.display2, Colors.white, semiboldInter),
                    ),
                  ),
                ),
              )
            ),
          )
        ],
      )
    );
  }

}
