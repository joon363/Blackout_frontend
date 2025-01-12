import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:bremen/pages/scanner_barcode_label.dart';
import 'package:bremen/pages/scanner_button_widgets.dart';
import 'package:bremen/pages/scanner_error_widget.dart';
import 'package:bremen/themes.dart';
export 'package:provider/provider.dart';
import 'package:bremen/Connection/state_manager.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() =>
  _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );

  @override
  Widget build(BuildContext context) {
    final globalState = Provider.of<GlobalState>(context, listen: true);
    globalState.resetQR();
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );

    return Scaffold(
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
                    child: ScannedBarcodeLabel(barcodes: controller.barcodes),
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
                painter: ScannerOverlay(scanWindow: scanWindow),
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
                    NumberInputButton(controller: controller),
                    ToggleFlashlightButton(controller: controller),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ExitButton(),
                    DebugContinueButton(),
                  ],
                ),
                SizedBox(height: defaultPadding*2,)

              ]
            ),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
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
      ..color = primaryColor
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
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
      borderRadius != oldDelegate.borderRadius;
  }
}
