import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/State/state_manager.dart';
import 'package:bremen/pages/components.dart';
import 'package:bremen/pages/pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: defaultPadding,
            children: [
              LogoCard(),
              NoticeCard(),
              ProfileCard(),
              Row(
                spacing: defaultPadding,
                children: [
                  MapCard(),
                  QRCard()
                ],
              ),
              InfoCallCard()
            ],
          )
        )
      )
    );
  }
}

class LogoCard extends StatelessWidget {
  const LogoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: defaultPadding,
        ),
        Image(
          image: Image.asset('assets/images/logo.png').image,
          height: 40,
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}

class NoticeCard extends StatelessWidget {
  const NoticeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: boxBlueColor, // 배경색
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
              return SizedBox(
                child: AlertDialog(
                  title: PText('준비 중입니다!', PFontStyle.headline2,textBlackColor, semiboldInter),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: PText('확인', PFontStyle.headline2,primaryColor, semiboldInter),
                    ),
                  ],
                ),
              );
            }
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: boxBlueColor,
            borderRadius: BorderRadius.circular(defaultBorderRadius)),
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PText("게임에서 미션 달성시, 할인쿠폰 지급🎉", PFontStyle.label,
                textBlackColor, regularInter),
              Icon(Icons.arrow_forward_ios, size: 12)
            ],
          )
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Material(
      elevation: 0,
      color: boxGrayColor, // 배경색
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      child: InkWell(
        borderRadius: BorderRadius.circular(defaultBorderRadius),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context){
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: Colors.black45, // 반투명 어두운 배경
                    ),
                  ),
                  Center(
                    child: ProfilePage(),
                  ),
                ],
              );
            }
          );
        },
        child: Container(
          //height: 140,
          padding: EdgeInsets.all(defaultPadding),
          //decoration: grayBox,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PText(
                        "${globalState.userName}님이 ",
                        PFontStyle.headline1,
                        textBlackColor,
                        boldInter),
                      PText("도로를 구한 시간 ", PFontStyle.headline1,
                        textBlackColor, boldInter),
                    ],
                  ),
                  ProfileImage(),
                ],
              ),
              RankIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

class QRCard extends StatelessWidget {
  const QRCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              color: Colors.grey, // 배경색 (이미지 로드 안 됐을 때 표시)
              borderRadius: BorderRadius.circular(                              defaultBorderRadius),
              image: DecorationImage(
                image: Image.asset('assets/images/qr.png').image,
                // 로컬 이미지 경로
                fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: defaultPadding*2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                PText("QR 스캔하고", PFontStyle.headline2, textWhiteColor, semiboldInter),
                PText("대여하기", PFontStyle.headline1, textWhiteColor, boldInter),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white10,
                onTap: () async {
                  Navigator.pushReplacementNamed(
                    context,
                    qrPageRoute,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MapCard extends StatelessWidget {
  const MapCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 270,
            decoration: BoxDecoration(
              color: Colors.grey, // 배경색 (이미지 로드 안 됐을 때 표시)
              borderRadius: BorderRadius.circular(                              defaultBorderRadius),
              image: DecorationImage(
                image: Image.asset('assets/images/map.png').image,
                // 로컬 이미지 경로
                fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: defaultPadding/2, bottom: defaultPadding*2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PText("주차구역 확인하고", PFontStyle.body1, textBlackColor, semiboldInter),
                PText("지쿠 찾기", PFontStyle.body1, textBlackColor, semiboldInter),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                highlightColor: Colors.white10,

                onTap: () {
                  Navigator.pushNamed(
                    context,
                    htmlViewPageRoute,
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCallCard extends StatelessWidget {
  const InfoCallCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: defaultPadding,
      children: [
        Expanded(
          child: Material(
            elevation: 0,
            color: boxGrayColor, // 배경색
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: InkWell(
              //highlightColor: primaryColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return SizedBox(
                      child: AlertDialog(
                        title: PText('준비 중입니다!', PFontStyle.headline2,textBlackColor, semiboldInter),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: PText('확인', PFontStyle.headline2,primaryColor, semiboldInter),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: boxGrayColor,
                  borderRadius: BorderRadius.circular((defaultBorderRadius)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      CupertinoIcons.question_circle_fill,
                      color: primaryColor,
                      size: 24,
                    ),
                    PText("서비스 안내", PFontStyle.label, textBlackColor,
                      regularInter)
                  ],
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Material(
            elevation: 0,
            color: boxGrayColor, // 배경색
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            child: InkWell(
              //highlightColor: primaryColor,
              borderRadius: BorderRadius.circular(defaultBorderRadius),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context){
                    return SizedBox(
                      child: AlertDialog(
                        title: PText('준비 중입니다!', PFontStyle.headline2,textBlackColor, semiboldInter),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: PText('확인', PFontStyle.headline2,primaryColor, semiboldInter),
                          ),
                        ],
                      ),
                    );
                  }
                );
              },
              child: Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: boxGrayColor,
                  borderRadius: BorderRadius.circular(                          (defaultBorderRadius)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.headset_mic_rounded,
                      color: primaryColor,
                      size: 24,
                    ),
                    PText("고객센터", PFontStyle.label, textBlackColor,
                      regularInter)
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
