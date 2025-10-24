class OnboardingData {
  final String image;
  final String title;
  final String description;
  final bool isLastPage;

  OnboardingData({
    required this.image,
    required this.title,
    required this.description,
    this.isLastPage = false,
  });
}
