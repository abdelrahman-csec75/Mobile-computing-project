import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/catalog_provider.dart';
import '../../utils/app_theme.dart';
import '../../widgets/app_scaffold.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _line = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _line.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const frame = 240.0;

    return AppScaffold(
      title: 'Scan barcode',
      showBack: true,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF111A26),
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Center(
                  child: Container(
                    width: frame,
                    height: frame,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: AppTheme.ball, width: 3),
                    ),
                    child: AnimatedBuilder(
                      animation: _line,
                      builder: (_, _) => Stack(
                        children: [
                          Positioned(
                            left: 14,
                            right: 14,
                            top: 14 + _line.value * (frame - 34),
                            child: Container(
                              height: 3,
                              decoration: BoxDecoration(
                                color: AppTheme.ball,
                                borderRadius: BorderRadius.circular(2),
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
            const SizedBox(height: 16),
            const Text(
              'Point the camera at the equipment barcode',
              style: TextStyle(color: AppTheme.muted),
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Simulate scan (mock)'),
              onPressed: () {
                final code =
                    context.read<CatalogProvider>().equipment[2].barcode;
                Navigator.pop(context, code);
              },
            ),
          ],
        ),
      ),
    );
  }
}
