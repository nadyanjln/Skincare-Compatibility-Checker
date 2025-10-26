import 'package:capstone/ui/result/widget/ResultIngredientListWidget.dart';
import 'package:capstone/ui/result/widget/result_card.dart';
import 'package:flutter/material.dart';
import '../../style/skincare_text_style.dart';
import '../bottom_navbar.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9FAFB),
      appBar: AppBar(
        title: const Text("Result"),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ResultCard(resultCheck: 'Safe'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Your Products and Ingredients",
                      style: SkincareTextStyle.titleMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: const ResultIngredientListWidget(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacementNamed(context, '/home');
          } else if (index == 1) {
            Navigator.pushReplacementNamed(context, '/cek_kombinasi');
          } else if (index == 2) {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        },
      ),
    );
  }
}
