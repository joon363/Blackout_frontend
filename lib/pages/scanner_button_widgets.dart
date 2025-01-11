import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      //iconSize: 32.0,
      icon: CircleAvatar(
        radius: 30, // 원의 반지름
        backgroundColor: Colors.white, // 하얀 배경
        child: Icon(CupertinoIcons.xmark, size: 30, color: Colors.black,)
      ),
      onPressed: () async {
        Navigator.pop(context);
      },
    );
  }
}
class DebugContinueButton extends StatelessWidget {
  const DebugContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      //iconSize: 32.0,
      icon: CircleAvatar(
        radius: 30, // 원의 반지름
        backgroundColor: Colors.white, // 하얀 배경
        child: Icon(CupertinoIcons.arrow_right, size: 30, color: primaryColor)
      ),
      onPressed: () async {
        Navigator.pushReplacementNamed(
          context,
          gameLoadingPageRoute,
        );
      },
    );
  }
}
class DebugParkContinueButton extends StatelessWidget {
  const DebugParkContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.white,
      //iconSize: 32.0,
      icon: CircleAvatar(
          radius: 30, // 원의 반지름
          backgroundColor: Colors.white, // 하얀 배경
          child: Icon(CupertinoIcons.arrow_right, size: 30, color: primaryColor)
      ),
      onPressed: () async {
        Navigator.pushReplacementNamed(
          context,
          rideResultPageRoute,
        );
      },
    );
  }
}
class NumberInputButton extends StatelessWidget {
  const NumberInputButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 하얀 원
        CircleAvatar(
          radius: 30, // 원의 반지름
          backgroundColor: Colors.white, // 하얀 배경
          child: Padding(
            padding: const EdgeInsets.all(10.0), // 이미지 패딩
            child: Image.asset(
              'assets/images/numbers.png', // 이미지 경로
              fit: BoxFit.contain,
            ),
          ),
        ),
        SizedBox(height: 10), // 이미지와 텍스트 사이 간격
        PText("번호 입력", PFontStyle.label, textWhiteColor, regularInter),
      ],
    );
  }
}

class SwitchCameraButton extends StatelessWidget {
  const SwitchCameraButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        final int? availableCameras = state.availableCameras;

        if (availableCameras != null && availableCameras < 2) {
          return const SizedBox.shrink();
        }

        final Widget icon;

        switch (state.cameraDirection) {
          case CameraFacing.front:
            icon = const Icon(Icons.camera_front);
          case CameraFacing.back:
            icon = const Icon(Icons.camera_rear);
        }

        return IconButton(
          color: Colors.white,
          iconSize: 32.0,
          icon: icon,
          onPressed: () async {
            await controller.switchCamera();
          },
        );
      },
    );
  }
}

class ToggleFlashlightButton extends StatelessWidget {
  const ToggleFlashlightButton({required this.controller, super.key});

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (!state.isInitialized || !state.isRunning) {
          return const SizedBox.shrink();
        }

        switch (state.torchState) {
          case TorchState.auto:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 하얀 원
                IconButton(
                  color: Colors.white,
                  //iconSize: 32.0,
                  icon: CircleAvatar(
                    radius: 30, // 원의 반지름
                    backgroundColor: Colors.white, // 하얀 배경
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // 이미지 패딩
                      child: Image.asset(
                        'assets/images/bulb.png', // 이미지 경로
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await controller.toggleTorch();
                  },
                ),
                //SizedBox(height: 10), // 이미지와 텍스트 사이 간격
                PText("라이트 켜기", PFontStyle.label, textWhiteColor, regularInter),
              ],
            );
          case TorchState.off:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 하얀 원
                IconButton(
                  color: Colors.white,
                  //iconSize: 32.0,
                  icon: CircleAvatar(
                    radius: 30, // 원의 반지름
                    backgroundColor: Colors.white, // 하얀 배경
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // 이미지 패딩
                      child: Image.asset(
                        'assets/images/bulb.png', // 이미지 경로
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await controller.toggleTorch();
                  },
                ),
                //SizedBox(height: 10), // 이미지와 텍스트 사이 간격
                PText("라이트 켜기", PFontStyle.label, textWhiteColor, regularInter),
              ],
            );
          case TorchState.on:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 하얀 원
                IconButton(
                  color: Colors.white,
                  //iconSize: 32.0,
                  icon: CircleAvatar(
                    radius: 30, // 원의 반지름
                    backgroundColor: Colors.white, // 하얀 배경
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // 이미지 패딩
                      child: Image.asset(
                        'assets/images/bulb.png', // 이미지 경로
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await controller.toggleTorch();
                  },
                ),

                //SizedBox(height: 10), // 이미지와 텍스트 사이 간격
                PText("라이트 켜기", PFontStyle.label, textWhiteColor, regularInter),
              ],
            );
          case TorchState.unavailable:
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 하얀 원
                IconButton(
                  color: Colors.white,
                  //iconSize: 32.0,
                  icon: CircleAvatar(
                    radius: 30, // 원의 반지름
                    backgroundColor: Colors.white, // 하얀 배경
                    child: Padding(
                      padding: const EdgeInsets.all(10.0), // 이미지 패딩
                      child: Icon(
                        Icons.no_flash,
                        size: 32.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await controller.toggleTorch();
                  },
                ),

                //SizedBox(height: 10), // 이미지와 텍스트 사이 간격
                PText("라이트 없음", PFontStyle.label, textGrayColor, regularInter),
              ],
            );
        }
      },
    );
  }
}
