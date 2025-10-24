import 'package:capstone/ui/camera/widget/scanner_overlay_painter.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';
import 'package:capstone/provider/ingredients_provider.dart';
import 'package:capstone/provider/camera_ocr_provider.dart';

class CameraOcrPage extends StatelessWidget {
  const CameraOcrPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap dengan ChangeNotifierProvider di sini
    return ChangeNotifierProvider(
      create: (_) => CameraOcrProvider(),
      child: const _CameraOcrContent(),
    );
  }
}

class _CameraOcrContent extends StatefulWidget {
  const _CameraOcrContent();

  @override
  State<_CameraOcrContent> createState() => _CameraOcrContentState();
}

class _CameraOcrContentState extends State<_CameraOcrContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeCamera();
    });
  }

  Future<void> _initializeCamera() async {
    try {
      final cameraProvider = context.read<CameraOcrProvider>();
      await cameraProvider.initializeCamera();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to initialize camera: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _captureAndProcessImage() async {
    try {
      final cameraProvider = context.read<CameraOcrProvider>();
      final detectedIngredients = await cameraProvider.captureAndProcessImage();

      if (!mounted) return;

      if (detectedIngredients.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Row(
              children: [
                Icon(Icons.warning, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text('No ingredients detected. Please try again.'),
                ),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        final provider = context.read<IngredientsProvider>();

        // Gabungkan semua hasil OCR dari satu foto jadi satu string, dipisahkan koma
        final combinedText = detectedIngredients.join(', ');

        // Tambahkan sebagai satu part ke provider
        provider.addIngredient(combinedText);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${detectedIngredients.length} ingredient(s) added to Lab',
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xff007BFF),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      print('Error processing image: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error processing image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff007BFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan Ingredients',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<CameraOcrProvider>(
        builder: (context, cameraProvider, child) {
          if (!cameraProvider.isCameraInitialized) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          return Stack(
            children: [
              // Camera preview
              SizedBox.expand(
                child: CameraPreview(cameraProvider.cameraController!),
              ),

              // Guide overlay
              Positioned.fill(
                child: CustomPaint(painter: ScannerOverlayPainter()),
              ),

              // Instructions
              const _InstructionsWidget(),

              // Capture button
              _CaptureButton(
                isProcessing: cameraProvider.isProcessing,
                onCapture: _captureAndProcessImage,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _InstructionsWidget extends StatelessWidget {
  const _InstructionsWidget();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'Position the ingredient list within the frame',
          style: TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final bool isProcessing;
  final VoidCallback onCapture;

  const _CaptureButton({required this.isProcessing, required this.onCapture});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: isProcessing
            ? const CircularProgressIndicator(color: Colors.white)
            : GestureDetector(
                onTap: onCapture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
