import 'package:flutter/material.dart';
import 'package:bremen/pages/pages.dart';
import '/route/route_constants.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: homePageRoute),
        builder: (context) => const HomePage(title: "hello"),
      );
    case rankPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: rankPageRoute),
        builder: (context) => const RankPage(),
      );
    case qrPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: qrPageRoute),
        builder: (context) => const BarcodeScannerWithOverlay(),
      );
    // case missionPageRoute:
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: missionPageRoute),
    //     builder: (context) => const MissionPage(),
    //   );
    // case missionDetailRoute:
    //   final String missionId = settings.arguments as String;
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: missionDetailRoute),
    //     builder: (context) => MissionDetailPage(missionId: missionId),
    //   );
    // case deliveryInputPageRoute:
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: deliveryInputPageRoute),
    //     builder: (context) => const DeliveryInputPage(),
    //   );
    // case deliveryCallingPageRoute:
    //   final missionRequestArgument argument = settings.arguments as missionRequestArgument;
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: deliveryCallingPageRoute),
    //     builder: (context) => DeliveryCallingPage(requestInfo: argument,),
    //   );
    // case deliveryFailPageRoute:
    //   final data = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: deliveryFailPageRoute),
    //     builder: (context) => DeliveryFailPage(requestInfo: data['requestInfo'], errorMessage: data['errorMessage']),
    //   );
    // case deliverySuccessPageRoute:
    //   final data = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: deliverySuccessPageRoute),
    //     builder: (context) => DeliverySuccessPage(requestInfo: data['requestInfo'],objectId: data['objectId'], missionId: data['missionId'],),
    //   );
    // case statusPageRoute:
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: statusPageRoute),
    //     builder: (context) => const StatusPage(),
    //   );
    // case loginLoadingPageRoute:
    //   return MaterialPageRoute(
    //     settings: RouteSettings(name: loginLoadingPageRoute),
    //     builder: (context) => LoginLoadingPage(),
    //   );
    default:
      return MaterialPageRoute(
        settings: RouteSettings(name: homePageRoute),
        builder: (context) => const HomePage(title:"hello"),
      );

  }
}
