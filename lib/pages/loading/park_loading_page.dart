import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ParkLoadingPage extends StatefulWidget {
  const ParkLoadingPage({super.key});

  @override
  State<ParkLoadingPage> createState() => _ParkLoadingPageState();
}

class _ParkLoadingPageState extends State<ParkLoadingPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () async {
        WidgetsFlutterBinding.ensureInitialized();
        List<CameraDescription> cameras = await availableCameras();
        Navigator.pushReplacementNamed(
          context,
          qrParkPageRoute,
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
            PText('주행 종료 중입니다.', PFontStyle.headline2, textBlackColor,semiboldInter),
            SizedBox(height: defaultPadding*3,),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                borderRadius: BorderRadius.circular(defaultBorderRadius), 
                image: DecorationImage(
                  image: AssetImage('assets/images/blocks.gif'),
                  fit: BoxFit.fitHeight, // 이미지를 박스 크기에 맞게 자르기
                ),
              ),
            ),
          ]
        ),
      ));
  }
}
