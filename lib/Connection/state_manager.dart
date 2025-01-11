import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

class GlobalState with ChangeNotifier {
  String userName = "BREMEN";
  String userRank = "Silver";
  int currentExp = 30;
  int nextRankExp = 100;

  Future<void> updateUserRank(String newRank) async {
    userRank = newRank;
    notifyListeners();
  }
  int getRemainExp() {
    return nextRankExp - currentExp;
  }
}

// import 'package:bremen/Connection/state_manager.dart';
// final globalState = Provider.of<GlobalState>(context, listen: false);