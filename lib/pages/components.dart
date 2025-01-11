import 'package:flutter/material.dart';
import 'package:bremen/Connection/state_manager.dart';
import 'package:bremen/themes.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.size = 35});
  final double size;

  @override
  Widget build(BuildContext context) {
    precacheImage(
      Image.asset('assets/images/scooter_badge.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/tree_badge.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/profile.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/map.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/qr.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/map_wide.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/bulb.png').image,
      context,
    );
    precacheImage(
      Image.asset('assets/images/numbers.png').image,
      context,
    );

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
