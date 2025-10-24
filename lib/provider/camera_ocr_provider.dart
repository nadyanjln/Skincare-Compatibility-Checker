import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

class CameraOcrProvider extends ChangeNotifier {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  bool _isProcessing = false;
  bool _isCameraInitialized = false;
  final TextRecognizer _textRecognizer = TextRecognizer();

  CameraController? get cameraController => _cameraController;
  bool get isProcessing => _isProcessing;
  bool get isCameraInitialized => _isCameraInitialized;

  Future<void> initializeCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras != null && _cameras!.isNotEmpty) {
        _cameraController = CameraController(
          _cameras![0],
          ResolutionPreset.high,
          enableAudio: false,
        );

        await _cameraController!.initialize();
        _isCameraInitialized = true;
        notifyListeners();
      }
    } catch (e) {
      print('Error initializing camera: $e');
      rethrow;
    }
  }

  Future<List<String>> captureAndProcessImage() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return [];
    }

    if (_isProcessing) return [];

    _isProcessing = true;
    notifyListeners();

    try {
      final XFile image = await _cameraController!.takePicture();
      final inputImage = InputImage.fromFilePath(image.path);
      final RecognizedText recognizedText = await _textRecognizer.processImage(
        inputImage,
      );

      List<String> detectedIngredients = _extractIngredients(
        recognizedText.text,
      );

      return detectedIngredients;
    } catch (e) {
      print('Error processing image: $e');
      rethrow;
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  List<String> _extractIngredients(String text) {
    List<String> ingredients = [];
    List<String> lines = text.split(RegExp(r'[,\n;:]'));

    for (String line in lines) {
      String cleaned = line.trim();
      if (cleaned.length > 2 && !RegExp(r'^\d+$').hasMatch(cleaned)) {
        cleaned = cleaned.replaceAll(RegExp(r'\d+%?'), '').trim();
        if (cleaned.isNotEmpty && !_isCommonNonIngredient(cleaned)) {
          ingredients.add(cleaned);
        }
      }
    }

    return ingredients;
  }

  bool _isCommonNonIngredient(String text) {
    final nonIngredients = [
      'ingredients',
      'contains',
      'may contain',
      'product',
      'warning',
    ];

    String lower = text.toLowerCase();
    return nonIngredients.any((word) => lower.contains(word));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _textRecognizer.close();
    super.dispose();
  }
}
