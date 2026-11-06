import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/haptic_helper.dart';
import '../../../shared/widgets/animated_scanner_box.dart';
import '../../../shared/widgets/puter_upgrade_modal.dart';
import '../../../shared/widgets/puter_auth_required_modal.dart';
import '../providers/scanner_provider.dart';
import '../services/scanner_service.dart';

class ScannerScreen extends ConsumerWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerState = ref.watch(scannerProvider);
    final scannerNotifier = ref.read(scannerProvider.notifier);

    Future<void> triggerScan(ImageSource source) async {
      HapticHelper.mediumImpact();
      final success = await scannerNotifier.captureAndScan(source);

      if (success && context.mounted) {
        if (scannerState.mode == ScanMode.menu) {
          context.push('/menu-analysis');
        } else {
          context.push('/analysis-result');
        }
      } else if (scannerState.errorMessage != null && context.mounted) {
        final err = scannerState.errorMessage!;
        final isAuthRequired = err.contains('Unauthorized') ||
            err.contains('auth_required') ||
            err.contains('authentication required') ||
            err.contains('Puter account authentication required') ||
            err.contains('Puter authentication required') ||
            err.contains('log in with your Puter account') ||
            err == '[object Object]';

        if (err.contains('insufficient_funds') || err.contains('allowance')) {
          PuterUpgradeModal.show(context, message: err);
        } else if (isAuthRequired) {
          PuterAuthRequiredModal.show(context, message: err);
        } else if (!err.contains('cancelled')) {
          final isNonFood = err.contains('food') ||
              err.contains('খাবার') ||
              err.contains('طعام');

          if (isNonFood) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: AppColors.darkSurface,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                icon: const Icon(Icons.no_meals_rounded, color: AppColors.error, size: 40),
                title: const Text(
                  'No Food Detected',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
                ),
                content: Text(
                  err,
                  style: const TextStyle(color: AppColors.textSecondaryDark, fontSize: 13, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                actions: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        ref.read(scannerProvider.notifier).clearResults();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      ),
                      child: const Text('Try Another Image', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(err),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      }
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Simulated Camera Viewfinder Surface / Background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.0,
                colors: [Color(0xFF1E293B), Color(0xFF090D16)],
              ),
            ),
            child: Center(
              child: AnimatedScannerBox(
                size: 290,
                isScanning: scannerState.isScanning,
              ),
            ),
          ),

          // Top Header Toolbar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BackButton(color: Colors.white),
                  // Scanner Mode Switcher Pill
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _ModePill(
                          label: 'Dish',
                          isSelected: scannerState.mode == ScanMode.dish,
                          onTap: () => scannerNotifier.setMode(ScanMode.dish),
                        ),
                        _ModePill(
                          label: 'Menu',
                          isSelected: scannerState.mode == ScanMode.menu,
                          onTap: () => scannerNotifier.setMode(ScanMode.menu),
                        ),
                        _ModePill(
                          label: 'Label OCR',
                          isSelected: scannerState.mode == ScanMode.nutritionLabel,
                          onTap: () => scannerNotifier.setMode(ScanMode.nutritionLabel),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      scannerState.isFlashOn ? Icons.flash_on_rounded : Icons.flash_off_rounded,
                      color: scannerState.isFlashOn ? AppColors.tertiary : Colors.white,
                    ),
                    onPressed: () {
                      HapticHelper.lightImpact();
                      scannerNotifier.toggleFlash();
                    },
                  ),
                ],
              ),
            ),
          ),

          // Bottom Scanning Controls & Stage Progress
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Informative Stage Progress Feedback
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: scannerState.isScanning
                            ? AppColors.primary.withValues(alpha: 0.5)
                            : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (scannerState.isScanning) ...[
                          const SizedBox(
                            width: 14,
                            height: 14,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Flexible(
                          child: Text(
                            scannerState.isScanning
                                ? (scannerState.currentStageMessage ?? 'Analyzing visual food features...')
                                : scannerState.mode == ScanMode.dish
                                    ? 'Align plate inside the frame for best accuracy'
                                    : scannerState.mode == ScanMode.menu
                                        ? 'Capture restaurant menu items & prices'
                                        : 'Align packaged food nutrition table',
                            style: TextStyle(
                              fontSize: 12,
                              color: scannerState.isScanning ? AppColors.primaryLight : Colors.white70,
                              fontWeight: scannerState.isScanning ? FontWeight.w600 : FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (scannerState.isScanning) ...[
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              HapticHelper.lightImpact();
                              scannerNotifier.cancelScan();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Actions Row: Gallery, Shutter Button, Quick Flip
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Pick from Gallery
                        IconButton(
                          onPressed: scannerState.isScanning
                              ? null
                              : () => triggerScan(ImageSource.gallery),
                          icon: const Icon(Icons.photo_library_rounded, color: Colors.white, size: 28),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.15),
                            padding: const EdgeInsets.all(14),
                          ),
                        ),
                        // Big Shutter Button
                        GestureDetector(
                          onTap: scannerState.isScanning
                              ? null
                              : () => triggerScan(ImageSource.camera),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 4),
                            ),
                            padding: const EdgeInsets.all(5),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.primaryGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.5),
                                    blurRadius: 16,
                                  ),
                                ],
                              ),
                              child: scannerState.isScanning
                                  ? const Center(
                                      child: SizedBox(
                                        width: 28,
                                        height: 28,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 3,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : const Icon(
                                      Icons.camera_rounded,
                                      color: Colors.white,
                                      size: 36,
                                    ),
                            ),
                          ),
                        ),
                        // Mode Info / Seed Demo
                        IconButton(
                          onPressed: () {
                            HapticHelper.lightImpact();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Puter Multimodal Vision Engine Active. Tips: Ensure direct lighting & avoid extreme angles.'),
                              ),
                            );
                          },
                          icon: const Icon(Icons.help_outline_rounded, color: Colors.white, size: 28),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withValues(alpha: 0.15),
                            padding: const EdgeInsets.all(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModePill extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ModePill({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticHelper.selectionClick();
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: isSelected ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }
}
