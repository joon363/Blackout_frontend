import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:bremen/themes.dart';
const List<String> names = [
  'assets/images/beforerank.png',
  'assets/images/bronze.png',
  'assets/images/bulb.png',
  'assets/images/city.png',
  'assets/images/gold.png',
  'assets/images/iron.png',
  'assets/images/map.png',
  'assets/images/map_result.png',
  'assets/images/map_wide.png',
  'assets/images/numbers.png',
  'assets/images/platinum.png',
  'assets/images/profile.png',
  'assets/images/qr.png',
  'assets/images/rankup.png',
  'assets/images/scooter_badge.png',
  'assets/images/silver.png',
  'assets/images/stars.png',
  'assets/images/tree_badge.png',
];
class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.size = 35});
  final double size;

  @override
  Widget build(BuildContext context) {
    for(int i=0;i<names.length;i++) {
      precacheImage(
        Image
            .asset(names[i])
            .image,
        context,
      );
    }
    return CircleAvatar(
      radius: size, // 원의 크기 설정
      backgroundImage: Image.asset('assets/images/profile.png').image,
      backgroundColor: Colors.white,
    );
  }
}

class RankIndicator extends StatelessWidget {
  const RankIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: false);
    return Column(
      spacing: defaultPadding/2,
      children: [
        Row(
          children: [
            PText(globalState.userRank, PFontStyle.label, primaryColor,
              semiboldInter),
            PText(" (다음 랭크까지 ${globalState.getRemainExp()}EXP)",
              PFontStyle.label, textGrayColor, semiboldInter)
          ],
        ),
        SizedBox(
          height: 10,
          child: LinearProgressIndicator(
            value: globalState.currentExp / globalState.nextRankExp,
            // 진행 정도 (0.0 ~ 1.0)
            backgroundColor: Colors.white,
            // 배경색
            color: primaryColor, // 진행 바 색상
          ),
        )
      ],
    );
  }
}
