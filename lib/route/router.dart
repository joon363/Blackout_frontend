import 'package:bremen/pages/result_loading_page.dart';
import 'package:bremen/pages/ride_result_page.dart';
import 'package:flutter/material.dart';
import 'package:bremen/pages/pages.dart';
import '/route/route_constants.dart';
import 'package:camera/camera.dart';

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
        builder: (context) => const QRPage(),
      );
    case qrParkPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: qrParkPageRoute),
        builder: (context) => const QRParkPage(),
      );
    case cameraPageRoute:
      final List<CameraDescription> _cameras = settings.arguments as List<CameraDescription>;
      //
      return MaterialPageRoute(
        settings: RouteSettings(name: cameraPageRoute),
        builder: (context) => CameraPage(cameras: _cameras),
      );
    case loginPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: loginPageRoute),
        builder: (context) => LoginPage(),
      );
    case gameLoadingPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: gameLoadingPageRoute),
        builder: (context) => GameLoadingPage(),
      );
    case parkLoadingPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: parkLoadingPageRoute),
        builder: (context) => ParkLoadingPage(),
      );
    case resultLoadingPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: resultLoadingPageRoute),
        builder: (context) => ResultLoadingPage(),
      );
    case htmlViewPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: htmlViewPageRoute),
        builder: (context) => WebViewPage(),
      );
    case rideResultPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: rideResultPageRoute),
        builder: (context) => RideResultPage(),
      );
    case parkResultPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: parkResultPageRoute),
        builder: (context) => ParkResultPage(),
      );
    case rankResultPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: rankResultPageRoute),
        builder: (context) => RankResultPage(),
      );
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => RankResultPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0); // 새 화면이 오른쪽에서 시작
          const end = Offset.zero;        // 새 화면이 제자리로 이동
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
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
