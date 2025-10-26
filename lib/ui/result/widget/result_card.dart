import 'package:flutter/material.dart';

class ResultCard extends StatefulWidget {
  final String resultCheck;
  const ResultCard({super.key, required this.resultCheck});

  @override
  State<ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  Color? get accentColor => switch (widget.resultCheck) {
    'Safe' => const Color(0xFF2E7D32),
    'Aware' => const Color(0xFFFBC02D),
    'Unsafe' => const Color(0xFFD93B3B),
    _ => const Color(0xFF2E7D32),
  };

  Color? get cardColor => switch (widget.resultCheck) {
    'Safe' => const Color(0xFFE8FBE8),
    'Aware' => const Color(0xFFFFF7E0),
    'Unsafe' => const Color(0xFFFEEAEA),
    _ => const Color(0xFFE8FBE8),
  };

  Color? get subtitleColor => switch (widget.resultCheck) {
    'Safe' => const Color(0xFF388E3C),
    'Aware' => const Color(0xFFF9A825),
    'Unsafe' => const Color(0xFFB83636),
    _ => const Color(0xFF388E3C),
  };

  IconData get iconData => switch (widget.resultCheck) {
    'Safe' => Icons.check,
    'Aware' => Icons.warning,
    'Unsafe' => Icons.close,
    _ => Icons.check,
  };

  String get titleText => switch (widget.resultCheck) {
    'Safe' => 'Safe To Use Together',
    'Aware' => 'Need Attention',
    'Unsafe' => 'Not Safe To Use tTogether',
    _ => 'Aman digunakan bersama',
  };

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 420),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular red icon with white X
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: accentColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Title + subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titleText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      height: 1.15,
                      color: accentColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipisicing elit.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: subtitleColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
