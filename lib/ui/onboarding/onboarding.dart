import 'package:capstone/ui/onboarding/models/onboarding_data.dart';
import 'package:capstone/ui/onboarding/provider/onboarding_provider.dart';
import 'package:capstone/ui/onboarding/widget/onboarding_buttons.dart';
import 'package:capstone/ui/onboarding/widget/onboarding_page.dart';
import 'package:capstone/ui/onboarding/widget/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static final List<OnboardingData> _pages = [
    OnboardingData(
      image: "assets/onboarding1.png",
      title: "Know Your Product",
      description:
          "Let's check the ingredients and benefits of your favorite skincare.",
    ),
    OnboardingData(
      image: "assets/onboarding2.png",
      title: "Compare!",
      description: "Know your skincare and use it more safely!",
    ),
    OnboardingData(
      image: "assets/onboarding3.png",
      title: "Explore the app",
      description:
          "Discover and compare skincare ingredients to find what’s best for your skin type.",
      isLastPage: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Consumer<OnboardingProvider>(
                  builder: (context, provider, child) {
                    return PageView.builder(
                      controller: provider.pageController,
                      onPageChanged: provider.onPageChanged,
                      itemCount: _pages.length,
                      itemBuilder: (context, index) {
                        return OnboardingPage(
                          data: _pages[index],
                          onBack: provider.previousPage,
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Consumer<OnboardingProvider>(
                  builder: (context, provider, child) {
                    return Column(
                      children: [
                        // Page Indicator
                        PageIndicator(
                          pageCount: _pages.length,
                          currentPage: provider.currentPage,
                        ),
                        const SizedBox(height: 24),

                        // Bottom Buttons
                        OnboardingButtons(
                          isLastPage: _pages[provider.currentPage].isLastPage,
                          isFirstPage: provider.currentPage == 0,
                          onNext: provider.nextPage,
                          onPrevious: provider.previousPage,
                          onSkip: provider.skip,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}