import 'package:flutter/material.dart';

class OnboardingButtons extends StatelessWidget {
  final bool isLastPage;
  final bool isFirstPage;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final VoidCallback onSkip;

  const OnboardingButtons({
    super.key,
    required this.isLastPage,
    required this.isFirstPage,
    required this.onNext,
    required this.onPrevious,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    if (isLastPage) {
      return _LastPageButtons();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: isFirstPage ? onSkip : onPrevious,
          child: Text(
            isFirstPage ? 'Skip' : 'Back',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
        ),
        TextButton(
          onPressed: onNext,
          child: const Text(
            'Next',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF4C7BF4),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _LastPageButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4C7BF4),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Colors.grey),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Create account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ],
    );
  }
}
