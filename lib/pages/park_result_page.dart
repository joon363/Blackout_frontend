import 'package:bremen/route/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:bremen/themes.dart';

class ParkResultPage extends StatefulWidget {
  const ParkResultPage({super.key});

  @override
  State<ParkResultPage> createState() => _ParkResultPageState();
}

class _ParkResultPageState extends State<ParkResultPage>
  with SingleTickerProviderStateMixin {

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
                Container(
                  margin: EdgeInsets.only(top: defaultPadding, left: defaultPadding, right: defaultPadding),
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                    borderRadius: BorderRadius.circular(defaultBorderRadius),
                    border: Border.all(color: primaryColor, width: 4),// 모서리를 둥글게
                    image: DecorationImage(
                      image: AssetImage('assets/images/scooter_park.png'),
                      // 로컬 이미지 경로
                      fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: defaultPadding,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("주차 구역에 올바르게 주차했습니다.",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: textBlackColor,
                              fontWeight: boldInter,
                              fontSize: 20,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: defaultPadding,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("+2 EXP",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: primaryColor,
                                  fontWeight: boldInter,
                                  fontSize: 32,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text("를",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  color: textBlackColor,
                                  fontWeight: semiboldInter,
                                  fontSize: 16,
                                  decoration: TextDecoration.none,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(width: 5,)
                            ],
                          ),
                          Text("추가로 받았습니다.",
                            style: TextStyle(
                              fontFamily: "Inter",
                              color: textBlackColor,
                              fontWeight: semiboldInter,
                              fontSize: 16,
                              decoration: TextDecoration.none,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
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
                              Navigator.pushReplacementNamed(context, rideResultPageRoute);
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
