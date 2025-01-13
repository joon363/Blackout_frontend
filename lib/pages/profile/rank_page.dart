import 'package:bremen/themes.dart';
import 'package:flutter/material.dart';
import 'package:bremen/State/state_manager.dart';

class RankPage extends StatelessWidget {
  const RankPage({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: PText("랭크별 혜택 안내", PFontStyle.headline1, textBlackColor, semiboldInter),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);  // 뒤로 가기
          },
        ),
      ),
      body: Padding(padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: defaultPadding/2,
          children: [
            PText("얻은 랭크 점수로\n상시 할인 혜택을 받으세요", PFontStyle.headline2, textBlackColor, boldInter),
            Expanded(
              child: ListView.builder(
                itemCount: RankInfo.rankCount,  // 리스트 항목 수
                //shrinkWrap: true,
                itemBuilder: (context, index) {
                  // 각 항목에 index 값과 함께 표시
                  return Column(
                    spacing: defaultPadding,
                    children: [
                      Row(
                        spacing: defaultPadding,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: globalState.userRankIndex==index? primaryColorLight: boxGrayColor, // 배경색 (이미지 로드 안 됐을 때 표시)
                              borderRadius: BorderRadius.circular(                                defaultBorderRadius), 
                              image: DecorationImage(
                                image: Image.asset(RankInfo.imgSrcs[index]).image,
                                // 로컬 이미지 경로
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: defaultPadding/2,
                            children: [
                              Row(
                                spacing: defaultPadding,
                                children: [
                                  PText(RankInfo.names[index], PFontStyle.title2, globalState.userRankIndex==index? primaryColor: textBlackColor, boldInter),
                                  if(globalState.userRankIndex==index)
                                  Container(
                                    padding: EdgeInsets.symmetric(horizontal: defaultPadding/2, vertical: defaultPadding/4),
                                    decoration: BoxDecoration(
                                      color:primaryColorLight,
                                      borderRadius: BorderRadius.circular(defaultBorderRadius)),
                                    child: PText("현재 랭크", PFontStyle.body2, primaryColor, semiboldInter),
                                  ),
                                ],
                              ),
                              PText(RankInfo.explanations[index], PFontStyle.body2, globalState.userRankIndex==index? primaryColor: textBlackColor, semiboldInter),
                              PText(RankInfo.conditions[index], PFontStyle.body2, globalState.userRankIndex==index? primaryColor: textBlackColor, regularInter)
                            ],
                          )
                        ],
                      ),
                      Divider(height: 2),
                      SizedBox(height: defaultPadding/4),
                    ],
                  );
                },
              ),
            )

          ],
        ),
      )
    );
  }
}
