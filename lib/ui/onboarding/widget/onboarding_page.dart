import 'package:capstone/ui/onboarding/models/onboarding_data.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  final VoidCallback onBack;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const SizedBox(height: 48),

          // Image
          Image.asset(
            data.image,
            height: 280,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 280,
                width: 280,
                color: Colors.grey.shade200,
                child: const Icon(
                  Icons.image_not_supported,
                  size: 80,
                  color: Colors.grey,
                ),
              );
            },
          ),
          const SizedBox(height: 48),

          // Title
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          // Description
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
              height: 1.5,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}