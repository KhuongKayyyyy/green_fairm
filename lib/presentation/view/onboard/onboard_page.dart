import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/onboard/widget/onboard_background.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();
  final List<String> _onBoardBackground = [
    AppImage.onboarding1,
    AppImage.onboarding2,
    AppImage.onboarding3,
  ];
  final List<String> _onBoardTitle = [
    "Welcome to Green Fairm",
    "Automatic Irrigation",
    "Update with the latest news",
  ];
  final List<String> _onBoardSubTitle = [
    "Your top solution for all your Agricultural needs",
    "Get your farm irrigated automatically",
    "Get the latest news on Agriculture",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _onBoardBackground.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return OnboardBackground(image: _onBoardBackground[index]);
            },
          ),
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: _buildOnBoardBottom(),
          )
        ],
      ),
    );
  }

  Column _buildOnBoardBottom() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Text(
            _onBoardTitle[_currentIndex],
            style: AppTextStyle.largeBold(),
          ),
        ),
        Text(
          _onBoardSubTitle[_currentIndex],
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(height: 50),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: _onBoardBackground.length,
              effect: ExpandingDotsEffect(
                dotColor: AppColor.white,
                activeDotColor: AppColor.accentColor,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  if (_currentIndex == _onBoardBackground.length - 1) {
                    // Navigator.pushNamed(context, "/login");
                    _currentIndex = 0;
                    _pageController.jumpToPage(_currentIndex);
                  } else {
                    _currentIndex++;
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                });
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.accentColor),
                child: Text(
                  "Continue",
                  style:
                      AppTextStyle.defaultBold(color: AppColor.secondaryColor),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
