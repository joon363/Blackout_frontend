import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/pages/components.dart';
import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultPadding),
      child:Column(
        children: [
          // images
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: Image.asset('assets/images/map_wide.png').image,
                    // 로컬 이미지 경로
                    fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                  ),

                ),
              ),
              SizedBox(
                height: 200,
                child:Image.asset('assets/images/profile.png'),
              ),
            ],
          ),

          // profile~menus
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: defaultPadding/2,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileImage(size: 50),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PText(globalState.userName, PFontStyle.title1, textBlackColor, semiboldInter),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 150,
                              height: 1, // 선의 두께
                              color: Colors.black, // 선의 색상
                            ),
                            PText("가입 번호: 010-1234-5678", PFontStyle.label, textBlackColor, regularInter),
                          ],

                        )
                      ],
                    )
                  ],
                ),
                WidgetSwitcher(),
              ],
            ),
          ),

          // buttons
        ],
      ),
    );
  }
}

class WidgetSwitcher extends StatefulWidget {
  const WidgetSwitcher({super.key});

  @override
  State<WidgetSwitcher> createState() => _WidgetSwitcherState();
}

class _WidgetSwitcherState extends State<WidgetSwitcher> {
  int selectedButton = 1; // 1번 버튼이 기본 선택

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 선택된 위젯 표시
        Container(
          height: 250,
          alignment: Alignment.topCenter,
          child: selectedButton == 1? InfoCard(): RankCard(),
        ),

        // 버튼 1, 2
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedButton = 1; // 버튼 1 선택
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // radius 0
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.person, size: 16, color: selectedButton == 1 ? primaryColor : Colors.grey,),
                  PText("기본 정보", PFontStyle.body1, selectedButton == 1 ? primaryColor : Colors.grey, semiboldInter)
                ],
              ),
            ),),
            Flexible(child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedButton = 2; // 버튼 1 선택
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero, // radius 0
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.leaderboard, size: 16, color: selectedButton == 2 ? primaryColor : Colors.grey,),
                  PText("랭크", PFontStyle.body1, selectedButton == 2 ? primaryColor : Colors.grey, semiboldInter)
                ],
              ),
            ),),


          ],
        ),
        //const SizedBox(height: 20),
      ],
    );
  }
}

class InfoCard extends StatelessWidget{
  const InfoCard ({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: defaultPadding/2,
      children: [
        PText("나의 지갑", PFontStyle.headline2, textBlackColor, boldInter),
        Divider(
          height: 2,
          thickness: 1,
          color: Colors.black,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText("쿠폰/패스", PFontStyle.label, textBlackColor, regularInter),
            Row(
              spacing: defaultPadding,
              children: [
                PText("0개", PFontStyle.label, textBlackColor, regularInter),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText("구독 관리", PFontStyle.label, textBlackColor, regularInter),
            Row(
              spacing: defaultPadding,
              children: [
                PText("구독 없음", PFontStyle.label, Colors.black87, regularInter),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText("결제 관리", PFontStyle.label, textBlackColor, regularInter),
            Row(
              spacing: defaultPadding,
              children: [
                PText("카카오페이", PFontStyle.label, textBlackColor, regularInter),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText("운전면허", PFontStyle.label, textBlackColor, regularInter),
            Row(
              spacing: defaultPadding,
              children: [
                PText("등록 완료", PFontStyle.label, textBlackColor, regularInter),
                Icon(Icons.arrow_forward_ios, size: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}

class RankCard extends StatelessWidget{
  const RankCard ({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PText("나의 랭크", PFontStyle.headline2, textBlackColor, boldInter),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(
                  context,
                  rankPageRoute,
                );
              },
              child: Row(
                spacing: defaultPadding/2,
                children: [
                  PText("랭크 안내", PFontStyle.label, textBlackColor, regularInter),
                  Icon(Icons.arrow_forward_ios, size: 12,),
                ],
              ),
            ),

          ],
        ),
        SizedBox(height: defaultPadding/2,),
        Divider(
          height: 2,
          thickness: 1,
          color: Colors.black,
        ),
        RankIndicator(),
        SizedBox(height: defaultPadding/2,),
        PText("배지 컬렉션", PFontStyle.headline2, textBlackColor, boldInter),
        Row(
          spacing: defaultPadding*1,
          children: [
            Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                    image: DecorationImage(
                      image: Image.asset('assets/images/tree_badge.png').image,
                      // 로컬 이미지 경로
                      fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                    ),
                  ),
                ),
                PText("나무 배지", PFontStyle.caption1, textBlackColor, regularInter),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                    image: DecorationImage(
                      image: Image.asset('assets/images/scooter_badge.png').image,
                      // 로컬 이미지 경로
                      fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                    ),
                  ),
                ),
                PText("스쿠터 사용 배지", PFontStyle.caption1, textBlackColor, regularInter),
              ],
            )
          ],
        )


      ],
    );
  }
}