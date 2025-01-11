import 'package:bremen/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/pages/components.dart';

class RideResultPage extends StatefulWidget {
  const RideResultPage({super.key});

  @override
  State<RideResultPage> createState() => _RideResultPageState();
}

class _RideResultPageState extends State<RideResultPage>
with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    // AnimationController 설정
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // 애니메이션 지속 시간
      vsync: this,
    );

    // Tween을 이용해 0.0에서 1.0까지 애니메이션 생성
    _animation = Tween<double>(begin: 0.2, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // 부드러운 애니메이션 효과
      ),
    );

    // 애니메이션 실행
    _controller.forward();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey, // 배경색 (이미지 로드 안 됐을 때 표시)
            borderRadius: BorderRadius.circular(defaultBorderRadius), // 모서리를 둥글게
            image: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              image: Image.asset('assets/images/city.png').image,
              // 로컬 이미지 경로
              fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding), //vertical: defaultPadding*4),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(defaultBorderRadius)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/stars.png'),
                Image.asset('assets/images/map_result.png'),
                Padding(padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: defaultPadding/2,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("얻은 코인 합계", PFontStyle.label, textBlackColor, semiboldInter),
                          PText("10/30개", PFontStyle.label, textBlackColor, semiboldInter),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("탑승 시간", PFontStyle.label, textBlackColor, semiboldInter),
                          PText("16:49", PFontStyle.label, textBlackColor, semiboldInter),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("탑승 거리", PFontStyle.label, textBlackColor, semiboldInter),
                          PText("600m", PFontStyle.label, textBlackColor, semiboldInter),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("최종 금액", PFontStyle.label, textBlackColor, semiboldInter),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            spacing: defaultPadding/2,
                            children: [
                              PText("2% 할인된 금액", PFontStyle.caption1, primaryColor, semiboldInter),
                              PText("1,050원", PFontStyle.label, textBlackColor, semiboldInter),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("기기 QR 번호", PFontStyle.label, textBlackColor, semiboldInter),
                          PText("273636", PFontStyle.label, textBlackColor, semiboldInter),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          PText("랭크 Exp가 5 상승하였습니다!", PFontStyle.headline2, primaryColor, boldInter),
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return PText("${(_animation.value * 50).toInt()}/50", PFontStyle.caption1, textGrayColor, regularInter);
                            },
                          ),
                        ],
                      ),
                      AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _animation.value, // 애니메이션 값에 따라 진행
                            minHeight: 10,
                            backgroundColor: Colors.grey[300],
                            color: primaryColor,
                          );
                        },
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Material(
                          elevation: 0,
                          color: Colors.transparent, // 배경색
                          borderRadius: BorderRadius.circular(999),
                          child: InkWell(
                            highlightColor: primaryColor,
                            borderRadius: BorderRadius.circular(999),
                            onTap: (){
                              Navigator.pushReplacementNamed(context, rankResultPageRoute);
                            },
                            child: Container(
                                alignment: Alignment.center,
                                width: 150,
                                height: 40,
                                decoration: BoxDecoration(
                                  //color: primaryColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(999)),
                                  border: Border.all(color: primaryColor, width: 2),
                                ),
                                child: PText("NEXT", PFontStyle.headline2, primaryColor, regularInter),
                            ),
                          ),
                        ),
                      )

                    ],
                  ),)
              ],
            )
          ),
        )
      ],
    );
  }
}
