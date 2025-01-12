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
      final List<CameraDescription> cameras = settings.arguments as List<CameraDescription>;
      //
      return MaterialPageRoute(
        settings: RouteSettings(name: cameraPageRoute),
        builder: (context) => CameraPage(cameras: cameras),
      );
    case fakeCameraPageRoute:
      return MaterialPageRoute(
        settings: RouteSettings(name: fakeCameraPageRoute),
        builder: (context) => FakeCameraPage(),
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
    default:
    return MaterialPageRoute(
      settings: RouteSettings(name: homePageRoute),
      builder: (context) => const HomePage(title:"hello"),
    );

  }
}
