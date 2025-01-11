import 'package:bremen/route/route_constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bremen/themes.dart';

import 'package:http/http.dart' as http;
/// CameraApp is the Main Application.
class CameraPage extends StatefulWidget {
  /// Default Constructor
  const CameraPage({super.key, required this.cameras});
  final List<CameraDescription> cameras;
  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;

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
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    Future<void> _uploadImage(BuildContext context, String imagePath) async {
      try {
        final uri = Uri.parse("http://10.0.2.2/upload"); // 서버 URL
        final request = http.MultipartRequest('POST', uri);
        // 파일 추가
        request.files.add(
          await http.MultipartFile.fromPath('file', imagePath),
        );

        // 요청 전송
        final response = await request.send();

        // 응답 확인
        if (response.statusCode == 200) {
          print("image uploaded");
        }
        else {
          print("image upload fail: ${response.statusCode}");
        }
      }
      catch (e) {
        print("image upload error: ${e}");
      }
    }

    if (!controller.value.isInitialized) {
      return Container();
    }
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
                        homePageRoute,
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
