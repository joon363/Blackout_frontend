import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/cupertino.dart';
export 'package:provider/provider.dart';
import 'package:bremen/State/state_manager.dart';

class ExitButton extends StatelessWidget {
  const ExitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.white, // 배경색
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        //highlightColor: primaryColor,
        borderRadius: BorderRadius.circular(999),
        onTap: () async {
          Navigator.pushReplacementNamed(
            context,
            homePageRoute
          );
        },
        child: CircleAvatar(
          radius: 30, // 원의 반지름
          backgroundColor: Colors.white, // 하얀 배경
          child: Icon(CupertinoIcons.xmark, size: 25, color: Colors.black,)
        ),
      ),
    );
  }
}
class ContinueButton extends StatelessWidget {
  const ContinueButton({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);
    return Material(
      elevation: 0,
      color: Colors.white, // 배경색
      borderRadius: BorderRadius.circular(999),
      child: InkWell(
        //highlightColor: primaryColor,
        borderRadius: BorderRadius.circular(999),
        onTap: () async {
          if(globalState.getQR()!="") {
            Navigator.pushReplacementNamed(
              context,
              gameLoadingPageRoute,
            );
          }
        },
        child: CircleAvatar(
          radius: 30, // 원의 반지름
          backgroundColor: Colors.white, // 하얀 배경
          child: Icon(CupertinoIcons.arrow_right, size: 25, color: primaryColor)
        ),
      ),
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
    return Tooltip(
      triggerMode: TooltipTriggerMode.tap,
      message: "준비 중입니다.",
      textStyle: PTextStyle(textWhiteColor, PFontStyle.caption1, regularInter),
      decoration: BoxDecoration(
        color: primaryColor, // 배경색 (이미지 로드 안 됐을 때 표시)
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      child: Column(
        spacing: defaultPadding,
        children: [
          Material(
            elevation: 0,
            color: Colors.white, // 배경색
            borderRadius: BorderRadius.circular(999),
            child: InkWell(
              //highlightColor: primaryColor,
              borderRadius: BorderRadius.circular(999),
              onTap: () async {
                Navigator.pop(context);
              },
              child: CircleAvatar(
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
            ),
          ),
          PText("번호 입력", PFontStyle.label, textWhiteColor, regularInter),
        ],
      ),
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
        return TorchButton(controller, state);
      },
    );
  }
}
class TorchButton extends StatelessWidget {
  const TorchButton(
    this.controller,
    this.state,
    {super.key}
  );

  final MobileScannerController controller;
  final MobileScannerState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: defaultPadding,
      children: [
        Material(
          elevation: 0,
          color: Colors.white, // 배경색
          borderRadius: BorderRadius.circular(999),
          child: InkWell(
            //highlightColor: primaryColor,
            borderRadius: BorderRadius.circular(999),
            onTap: () async {
              await controller.toggleTorch();
            },
            child: CircleAvatar(
              radius: 30, // 원의 반지름
              backgroundColor: Colors.white, // 하얀 배경
              child: Padding(
                padding: const EdgeInsets.all(10.0), // 이미지 패딩
                child: state.torchState==TorchState.off?
                  Image.asset('assets/images/bulb.png',fit: BoxFit.scaleDown):
                  Icon(Icons.no_flash,size: 25,color: Colors.grey,)
              ),
            ),
          ),
        ),
        PText((state.torchState!=TorchState.unavailable || !state.isInitialized || !state.isRunning)?
            state.torchState==TorchState.on?"라이트 끄기":"라이트 켜기":"라이트 비활성화", PFontStyle.label, textWhiteColor, regularInter),
      ]
    );
  }
}
