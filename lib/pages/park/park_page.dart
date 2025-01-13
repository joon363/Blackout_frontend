import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:bremen/pages/scanner_components/scanner_barcode_label.dart';
import 'package:bremen/pages/scanner_components/scanner_button_widgets.dart';
import 'package:bremen/pages/scanner_components/scanner_error_widget.dart';
import 'package:bremen/themes.dart';
import 'package:bremen/route/route_constants.dart';
import 'package:flutter/cupertino.dart';
class ParkPage extends StatefulWidget {
  const ParkPage({super.key});

  @override
  State<ParkPage> createState() =>
  _ParkPageState();
}

class _ParkPageState extends State<ParkPage> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        Navigator.pushReplacementNamed(
          context,
          homePageRoute
        );
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: MobileScanner(
                fit: BoxFit.contain,
                controller: controller,
                scanWindow: scanWindow,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                overlayBuilder: (context, constraints) {
                  /// qr 위 텍스트
                  return Padding(
                    padding: const EdgeInsets.only(top: defaultPadding*5),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ScannedBarcodeLabel(barcodes: controller.barcodes,
                        text: '올바르게 주차되어 있는지 확인해 주세요.',),
                    ),
                  );
                },
              ),
            ),
            ValueListenableBuilder(
              valueListenable: controller,
              builder: (context, value, child) {
                if (!value.isInitialized ||
                  !value.isRunning ||
                  value.error != null) {
                  return const SizedBox();
                }

                return CustomPaint(
                  painter: ParkScannerOverlay(scanWindow: scanWindow),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                //padding: const EdgeInsets.all(16.0),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ToggleFlashlightButton(controller: controller),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        color: Colors.white,
                        //iconSize: 32.0,
                        icon: CircleAvatar(
                          radius: 30, // 원의 반지름
                          backgroundColor: Colors.white, // 하얀 배경
                          child: Icon(CupertinoIcons.arrow_right, size: 30, color: primaryColor)
                        ),
                        onPressed: () async {
                          final image = controller.returnImage;
                          Navigator.pushReplacementNamed(
                            context,
                            resultLoadingPageRoute,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: defaultPadding*2,)

                ]
              ),
            ),
          ],
        ),
      )
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}

class ParkScannerOverlay extends CustomPainter {
  const ParkScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
    this.cornerLength = 20.0, // 꺾쇠의 길이
    this.cornerWidth = 4.0, // 꺾쇠의 두께
  });

  final Rect scanWindow;
  final double borderRadius;
  final double cornerLength;
  final double cornerWidth;

  @override
  void paint(Canvas canvas, Size size) {
    // we need to pass the size to the custom paint widget
    final backgroundPath = Path()
    ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final cutoutPath = Path()
    ..addRRect(
      RRect.fromRectAndCorners(
        scanWindow,
        topLeft: Radius.circular(borderRadius),
        topRight: Radius.circular(borderRadius),
        bottomLeft: Radius.circular(borderRadius),
        bottomRight: Radius.circular(borderRadius),
      ),
    );

    final backgroundPaint = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.dstOver;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = errorColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    // 스캔 윈도우의 꺾쇠를 그림
    _drawCorners(canvas, scanWindow, borderPaint);
  }
  void _drawCorners(Canvas canvas, Rect rect, Paint paint) {
    final topLeft = rect.topLeft;
    final topRight = rect.topRight;
    final bottomLeft = rect.bottomLeft;
    final bottomRight = rect.bottomRight;

    // 각 꼭지점에 꺾쇠를 그림
    // Top-left corner
    canvas.drawLine(
      topLeft,
      Offset(topLeft.dx + cornerLength, topLeft.dy),
      paint,
    );
    canvas.drawLine(
      topLeft,
      Offset(topLeft.dx, topLeft.dy + cornerLength),
      paint,
    );

    // Top-right corner
    canvas.drawLine(
      topRight,
      Offset(topRight.dx - cornerLength, topRight.dy),
      paint,
    );
    canvas.drawLine(
      topRight,
      Offset(topRight.dx, topRight.dy + cornerLength),
      paint,
    );

    // Bottom-left corner
    canvas.drawLine(
      bottomLeft,
      Offset(bottomLeft.dx + cornerLength, bottomLeft.dy),
      paint,
    );
    canvas.drawLine(
      bottomLeft,
      Offset(bottomLeft.dx, bottomLeft.dy - cornerLength),
      paint,
    );

    // Bottom-right corner
    canvas.drawLine(
      bottomRight,
      Offset(bottomRight.dx - cornerLength, bottomRight.dy),
      paint,
    );
    canvas.drawLine(
      bottomRight,
      Offset(bottomRight.dx, bottomRight.dy - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(ParkScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
      borderRadius != oldDelegate.borderRadius;
  }
}
