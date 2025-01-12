
import 'package:bremen/route/route_constants.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'dart:async';
import 'package:bremen/themes.dart';
import 'package:bremen/Connection/API_manager.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

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
  double offset = 0.1;

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
          'frame_id': globalState.requestCount,
        }
        );
        globalState.addRequestCount();

        // 요청 보내기
        final response = await dio.post(
          url,
          data: formData,
        );

        final statusCode = response.statusCode;
        if (statusCode==200) {
          //Future.delayed(Duration(milliseconds: 50));
          final data = response.data;
          final result = data['score'];
          //print("image uploaded, score: $result");
          globalState.updateScore(result);

          return result;
        }
        else {
          //print("image upload fail: ${response.statusCode}");
          return 0.0;
        }
      }
      catch (e) {
        //print("image upload error: $e");
        return 0.0;
      }
    }
    Future<void> endRide(BuildContext context) async {
      final globalState = Provider.of<GlobalState>(context, listen: false);

      // 서버 URL
      final url = "$backendBaseUrl/endride";

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
        final formData = FormData.fromMap({});

        // 요청 보내기
        final response = await dio.post(
          url,
          data: formData,
        );

        final statusCode = response.statusCode;
        if (statusCode==200) {
          //Future.delayed(Duration(milliseconds: 50));
          //print("ride ended");
          final data = response.data;
          final result = data['average_point'];
          globalState.updateScore(result);
        }
        else {
          //print("ride end fail: ${response.statusCode}");
        }
      }
      catch (e) {
        //print("ride end request error: $e");
      }
    }

    Future<void> screenshot(BuildContext context) async {
      try {
        if (!context.mounted) return;
        final image = await controller.takePicture();
        double res = await uploadImage(context,image.path);
      }
      catch (e) {
        //print("error while screenshot: $e");
      }
    }

    Future<void> pollData(BuildContext context) async {
      final globalState = Provider.of<GlobalState>(context, listen: false);
      if(!isPolling){
        await screenshot(context);
        globalState.resetScore();
        globalState.resetRequestCount();
        isPolling = true;
        Timer timer = Timer.periodic(Duration(seconds: 1), (timer) async {
            await screenshot(context);
          }
        );
      }
    }

    if (!controller.value.isInitialized) {
      return Container();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
        pollData(context);
      }
    );
    final globalState = Provider.of<GlobalState>(context, listen: true);
    Color getProgressColor(double progress) {
      // 프로그레스 값이 0일 때 빨간색, 100일 때 초록색으로 변하도록 설정
      int red = ((1 - progress) * 255).toInt();  // 빨간색은 0에서 255로 감소
      int green = (progress * 255).toInt(); // 초록색은 0에서 255로 증가
      return Color.fromRGBO(red, green, 0, 1); // 빨간색, 초록색, 파란색 값 설정
    }
    double getValue(){
      double value = offset+globalState.getAvgScore() > 1 ? 1:offset+globalState.getAvgScore();
      //print(value);
      return value;
    }
    double barWidth = MediaQuery.of(context).size.width - 32;
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
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: defaultPadding*2, vertical: defaultPadding*7),
                  height: 20,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultBorderRadius)),
                  ),
                  child: LinearProgressIndicator(
                    value: getValue(), // 프로그레스 바 값 설정
                    minHeight: 10,
                    backgroundColor: Colors.transparent,
                    color: getProgressColor(getValue()),
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultBorderRadius)),
                  ),
                ),
                Positioned(
                  left: (getValue()-offset / 100) * (barWidth-32) +16, // 진행 값에 따른 아이콘 위치
                  top: 100, // 아이콘을 프로그레스 바 위로 띄움
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                      image: DecorationImage(
                        image: Image.asset('assets/images/fire.png').image,
                        // 로컬 이미지 경로
                        fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                      ),
                    ),
                  ),
                )
              ],
            ),
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
                    onTap: () async {
                      await endRide(context);

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
