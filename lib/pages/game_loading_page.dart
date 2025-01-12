import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class GameLoadingPage extends StatefulWidget {
  const GameLoadingPage({super.key});

  @override
  State<GameLoadingPage> createState() => _GameLoadingPageState();
}

class _GameLoadingPageState extends State<GameLoadingPage> {
  @override
  void initState() {
    super.initState();
    // 3초 대기 후 다음 페이지로 이동
    Future.delayed(Duration(seconds: 2), () async {
        WidgetsFlutterBinding.ensureInitialized();
        List<CameraDescription> cameras = await availableCameras();
        Navigator.pushReplacementNamed(
          context,
          cameraPageRoute,
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
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PText('탑승을 준비하고 있습니다', PFontStyle.headline2, textBlackColor,semiboldInter),
            SizedBox(height: defaultPadding*3,),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                borderRadius: BorderRadius.circular(defaultBorderRadius), // 모서리를 둥글게
                image: DecorationImage(
                  image: AssetImage('assets/images/blocks.gif'),
                  // 로컬 이미지 경로
                  fit: BoxFit.fitHeight, // 이미지를 박스 크기에 맞게 자르기
                ),
              ),
            ),
          ]
        ),
      ));
  }
}
