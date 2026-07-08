import 'dart:math' as math;

import 'package:flutter/material.dart';

class BiometricAuthenticationView extends StatelessWidget {
  final String title;
  final String description;
  final String instruction;
  final String buttonLabel;
  final String? faceImageAsset;

  const BiometricAuthenticationView({
    super.key,
    this.title = 'Autentikasi Diperlukan',
    this.description =
    'Gunakan kunci biometrik untuk menyatakan persetujuan.',
    this.instruction = 'Tempatkan wajah di depan kamera',
    this.buttonLabel = 'Mulai scan wajah',
    this.faceImageAsset,
  });

  void _close(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  void _startFaceScan(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 28,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 520,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.14),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          28,
                          24,
                          18,
                          0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: const TextStyle(
                                      color: Color(0xFF252525),
                                      fontSize: 21,
                                      height: 1.25,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    description,
                                    style: const TextStyle(
                                      color: Color(0xFF616161),
                                      fontSize: 15,
                                      height: 1.45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              onPressed: () => _close(context),
                              tooltip: 'Tutup',
                              visualDensity: VisualDensity.compact,
                              icon: const Icon(
                                Icons.close,
                                color: Color(0xFF555555),
                                size: 29,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                        ),
                        child: _FaceScanPreview(
                          instruction: instruction,
                          faceImageAsset: faceImageAsset,
                        ),
                      ),

                      const SizedBox(height: 22),

                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE4E4E4),
                      ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(
                          28,
                          20,
                          28,
                          22,
                        ),
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () => _startFaceScan(context),
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor:
                              const Color(0xFF062F5E),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              buttonLabel,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FaceScanPreview extends StatelessWidget {
  final String instruction;
  final String? faceImageAsset;

  const _FaceScanPreview({
    required this.instruction,
    required this.faceImageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (faceImageAsset != null)
              Image.asset(
                faceImageAsset!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const _FacePlaceholder();
                },
              )
            else
              const _FacePlaceholder(),

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [
                    Colors.black.withValues(alpha: 0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),

            Positioned(
              top: 16,
              left: 12,
              right: 12,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5C5C5C)
                        .withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.info,
                        color: Colors.white,
                        size: 17,
                      ),
                      const SizedBox(width: 7),
                      Flexible(
                        child: Text(
                          instruction,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Center(
              child: FractionallySizedBox(
                widthFactor: 0.53,
                heightFactor: 0.69,
                child: CustomPaint(
                  painter: _DashedOvalPainter(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FacePlaceholder extends StatelessWidget {
  const _FacePlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD6D8DA),
      alignment: Alignment.center,
      child: const Icon(
        Icons.person,
        size: 210,
        color: Color(0xFF8E9297),
      ),
    );
  }
}

class _DashedOvalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    const dashAngle = 0.09;
    const gapAngle = 0.065;

    double currentAngle = -math.pi / 2;

    while (currentAngle < math.pi * 1.5) {
      canvas.drawArc(
        rect,
        currentAngle,
        dashAngle,
        false,
        paint,
      );

      currentAngle += dashAngle + gapAngle;
    }
  }

  @override
  bool shouldRepaint(
      covariant _DashedOvalPainter oldDelegate,
      ) {
    return false;
  }
}