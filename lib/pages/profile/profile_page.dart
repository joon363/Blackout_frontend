import 'package:bremen/route/route_constants.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/pages/components.dart';
import 'package:flutter/material.dart';
import 'package:bremen/State/state_manager.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child:Image.asset('assets/images/profile.png'),
              ),
            ],
          ),

          // profile, menus
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(defaultPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: defaultPadding,
              children: [
                UpperProfileCard(),
                WidgetSwitcher(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpperProfileCard extends StatelessWidget {
  const UpperProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Row(
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
                  height: 1,
                  color: Colors.black,
                ),
                PText("가입 번호: 010-1234-5678", PFontStyle.label, textBlackColor, regularInter),
              ],
            )
          ],
        )
      ],
    );
  }
}

class WidgetSwitcher extends StatefulWidget {
  const WidgetSwitcher({super.key});

  @override
  State<WidgetSwitcher> createState() => _WidgetSwitcherState();
}

class _WidgetSwitcherState extends State<WidgetSwitcher> {
  int selectedButton = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 250,
          alignment: Alignment.topCenter,
          child: selectedButton == 1? InfoCard(): RankCard(),
        ),

        // 버튼 1, 2
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                      selectedButton = 1;
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person, size: 16, color: selectedButton == 1 ? primaryColor : Colors.grey,),
                    PText("기본 정보", PFontStyle.body1, selectedButton == 1 ? primaryColor : Colors.grey, semiboldInter)
                  ],
                ),
              ),
            ),
            Flexible(child: ElevatedButton(
                onPressed: () {
                  setState(() {
                      selectedButton = 2; // 버튼 1 선택
                    }
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.leaderboard, size: 16, color: selectedButton == 2 ? primaryColor : Colors.grey,),
                    PText("랭크", PFontStyle.body1, selectedButton == 2 ? primaryColor : Colors.grey, semiboldInter)
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget{
  const InfoCard ({super.key});
  @override
  Widget build(BuildContext context) {

    final List<Map<String, String>> items = [
    {'title': '쿠폰/패스', 'value': '0개'},
    {'title': '구독 관리', 'value': '구독 없음'},
    {'title': '결제 관리', 'value': '카카오페이'},
    {'title': '운전면허', 'value': '등록 완료'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: defaultPadding,
      children: [
        PText("나의 지갑", PFontStyle.headline2, textBlackColor, boldInter),
        Divider(height: 2),
        Column(
          spacing: defaultPadding,
          children: List.generate(items.length, (index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PText(items[index]['title']!, PFontStyle.label, textBlackColor, regularInter),
                  Row(
                    children: [
                      PText(items[index]['value']!, PFontStyle.label, textBlackColor, regularInter),
                      const Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
                ],
              );
            }
          )
        ),
      ],
    );
  }
}

class RankCard extends StatelessWidget{
  const RankCard ({super.key});
  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: defaultPadding,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: defaultPadding/2,
              children: [
                PText("나의 랭크", PFontStyle.headline2, textBlackColor, boldInter),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding/2, vertical: defaultPadding/4),
                  decoration: BoxDecoration(
                    color:primaryColorLight,
                    borderRadius: BorderRadius.circular(defaultBorderRadius)),
                  child: PText(globalState.userRank, PFontStyle.body2, primaryColor, semiboldInter),
                ),
              ],
            ),
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
        Divider(height: 2),
        //RankIndicator(),
        PText("배지 컬렉션", PFontStyle.headline2, textBlackColor, boldInter),
        Row(
          spacing: defaultPadding*1,
          children: List.generate(
            globalState.userBadges.length, (index) {
              return Tooltip(
                triggerMode: TooltipTriggerMode.tap,
                message: globalState.userBadges[index].condition,
                textStyle: PTextStyle(textWhiteColor, PFontStyle.caption1, regularInter),
                decoration: BoxDecoration(
                  color: primaryColor, // 배경색 (이미지 로드 안 됐을 때 표시)
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 배경색 (이미지 로드 안 됐을 때 표시)
                        image: DecorationImage(
                          image: Image.asset(globalState.userBadges[index].src).image,
                          // 로컬 이미지 경로
                          fit: BoxFit.cover, // 이미지를 박스 크기에 맞게 자르기
                        ),
                      ),
                    ),
                    PText(globalState.userBadges[index].name, PFontStyle.caption1, textBlackColor, regularInter)
                  ]
                ),
              );
            }
          ),
        )
      ],
    );
  }
}
