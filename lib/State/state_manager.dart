import 'package:flutter/material.dart';
export 'package:provider/provider.dart';
import 'dart:math';
class badge {
  final String name;
  final String src;
  final String condition;
  badge(
    this.name,
    this.src,
    this.condition,
  );
}
class GlobalState with ChangeNotifier {
  String userName = "BREMEN";
  String userRank = "Silver";
  List<badge> userBadges = [
    badge("나무 배지", 'assets/images/tree_badge.png', '5별 주행 1회 달성'),
    badge("스쿠터 배지", 'assets/images/scooter_badge.png', '스쿠터 주행 20회'),
  ];
  String scannedQR = "";
  int userRankIndex = 2;
  int requestCount = 0;
  int currentExp = 30;
  int nextRankExp = 100;
  String qrResult = "";
  double liveScore = 0.0;
  int scoreCount = 1;
  double totalScore = 0.0;
  double avgScore = 0.0;
  double avgScoreFromServer = 0.0;
  String session = "";
  void addRequestCount() {
    requestCount++;
  }
  void setQR(String qr) {
    scannedQR = qr;
    notifyListeners();
  }
  void resetQR() {
    scannedQR = "";
    notifyListeners();
  }
  String getQR() {
    return scannedQR;
  }
  void resetRequestCount() {
    requestCount=0;
  }
  void fetchAvgScore (double s){
    avgScoreFromServer = s;
    notifyListeners();
  }
  Future<void> updateUserRank(String newRank) async {
    userRank = newRank;
    notifyListeners();
  }
  int getRemainExp() {
    return nextRankExp - currentExp;
  }
  void setQrResult(String str) {
    qrResult = str;
  }
  void updateScore(double n){
    if(n==-1) {
      return;
    }
    scoreCount ++;
    liveScore = n;
    totalScore +=n;
    avgScore = totalScore/scoreCount/100;
    notifyListeners();
  }
  double getAvgScore() {
    return avgScore;
  }
  void resetScore(){
    liveScore = 0.0;
    avgScore = 0.0;
    scoreCount=1;
    totalScore=0;
    notifyListeners();
  }
}

class RankInfo {
  static const int rankCount = 5;
  static const List<String> names = [
    "IRON",
    "BRONZE",
    "SILVER",
    "GOLD",
    "PLATINUM",
  ];
  static const List<String> explanations = [
    "신규 라이더",
    "결제 금액 2% 할인",
    "결제 금액 5% 할인",
    "결제 금액 8% 할인",
    "결제 금액 10% 할인",
  ];
  static const List<String> conditions = [
    "",
    "시즌 내 30exp 달성",
    "시즌 내 70exp 달성",
    "시즌 내 120exp 달성",
    "시즌 내 200xp 달성",
  ];
  static const List<String> imgSrcs = [
    'assets/images/iron.png',
    'assets/images/bronze.png',
    'assets/images/silver.png',
    'assets/images/gold.png',
    'assets/images/platinum.png',
  ];
}

// import 'package:bremen/Connection/state_manager.dart';
// final globalState = Provider.of<GlobalState>(context, listen: false);
