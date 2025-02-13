import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/presentation/view/main/news/widget/breaking_news_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BreakingNewsSection extends StatefulWidget {
  const BreakingNewsSection({Key? key}) : super(key: key);

  @override
  State<BreakingNewsSection> createState() => _BreakingNewsSectionState();
}

class _BreakingNewsSectionState extends State<BreakingNewsSection> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 250, // Adjusted height
          child: PageView.builder(
            controller: _pageController,
            itemCount: 5,
            itemBuilder: (context, index) {
              return BreakingNewsItem();
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _pageController,
          count: 5,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: AppColors.accentColor,
          ),
        ),
      ],
    );
  }
}
