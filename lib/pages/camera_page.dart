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

import 'package:http/http.dart' as http;
const String _backendBaseUrl = "http://ec2-3-80-116-226.compute-1.amazonaws.com:5000";
const String _bearerToken = "test-token";

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

      final globalState = Provider.of<GlobalState>(context, listen: false);

      // 서버 URL
      final url = "$backendBaseUrl/video_frame";

      try {
        final dio = Dio();

        // 쿠키 관리 객체 설정
        final cookieJar = CookieJar();
        dio.interceptors.add(CookieManager(cookieJar));

        // 세션 쿠키 생성
        final sessionCookie = Cookie('session', globalState.session)
          ..domain = Uri.parse(url).host  // 쿠키의 domain 설정 (url에 맞게 설정)
          ..path = '/'                    // 쿠키의 path 설정
          ..httpOnly = true;               // HTTP 요청에서만 사용하도록 설정 (브라우저 접근 불가)

        // 쿠키를 CookieJar에 추가
        await cookieJar.saveFromResponse(Uri.parse(url), [sessionCookie]);
        // 멀티파트 데이터 생성
        final formData = FormData.fromMap({
          'frame': await MultipartFile.fromFile(imagePath),
          'frame_id': 0,
        }
        );

        // 요청 보내기
        final response = await dio.post(
          url,
          data: formData,
        );

        final statusCode = response.statusCode;
        if (statusCode==200) {
          //Future.delayed(Duration(milliseconds: 50));
          //print("image uploaded");
          final data = response.data;
          return data['score'];
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

      await screenshot(context);
      // if(!isPolling){
      //   isPolling = true;
      //   Timer timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      //     print("fuck");
      //     await screenshot(context);
      //   });
      // }
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
