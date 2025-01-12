import 'package:bremen/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:bremen/themes.dart';

class RankResultPage extends StatefulWidget {
  const RankResultPage({super.key});

  @override
  State<RankResultPage> createState() => _RankResultPageState();
}

class _RankResultPageState extends State<RankResultPage>{
  final String _imagePath = 'assets/images/beforerank.png';
  bool _showFirst = true;
  @override
  void initState() {
    super.initState();

    // 2초 후에 이미지 변경
    Future.delayed(Duration(seconds: 1), () {
        setState(() {
            _showFirst = false;
          }
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Stack(
      //alignment: Alignment.center,
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(defaultBorderRadius)),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(padding: EdgeInsets.only(top: defaultPadding*3),
                  child: Column(
                    children: [
                      AnimatedCrossFade(
                        duration: Duration(seconds: 1), // 페이드 애니메이션 지속 시간
                        firstChild: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.asset(
                              'assets/images/beforerank.png',
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            Padding (padding: EdgeInsets.all(defaultPadding/4),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius), // 모서리를 둥글게
                                  image: DecorationImage(
                                    image: Image.asset('assets/images/silver.png').image,
                                    // 로컬 이미지 경로
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        secondChild: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.asset(
                              'assets/images/rankup.png',
                              width: 300,
                              fit: BoxFit.cover,
                            ),
                            Padding (padding: EdgeInsets.all(defaultPadding/4),
                              child: Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                    defaultBorderRadius), // 모서리를 둥글게
                                  image: DecorationImage(
                                    image: Image.asset('assets/images/gold.png').image,
                                    // 로컬 이미지 경로
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        crossFadeState: _showFirst
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond, // 상태에 따라 표시 이미지 결정
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(padding: EdgeInsets.all(defaultPadding),
                          child: PText("랭크가 Silver에서 Gold로\n상승했습니다!", PFontStyle.headline2, textBlackColor, boldInter),
                        )
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: defaultPadding,),
                          Text("이제부터 3% 할인 혜택을\n받을 수 있어요!",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: primaryColor,
                              fontWeight: boldInter,
                              fontSize: 24,
                              decoration: TextDecoration.none,

                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(padding: EdgeInsets.all(defaultPadding),
                            child:LinearProgressIndicator(
                              value: 0.05, // 애니메이션 값에 따라 진행
                              minHeight: 10,
                              backgroundColor: Colors.grey[300],
                              color: primaryColor,
                            )
                          ),
                          Material(
                            elevation: 0,
                            color: Colors.transparent, // 배경색
                            borderRadius: BorderRadius.circular(999),
                            child: InkWell(
                              highlightColor: primaryColor,
                              borderRadius: BorderRadius.circular(999),
                              onTap: (){
                                Navigator.pushReplacementNamed(context, homePageRoute);
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
                                child: PText("OK", PFontStyle.headline2, primaryColor, regularInter),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  )
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
