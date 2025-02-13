import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/core/constant/app_image.dart';
import 'package:green_fairm/core/constant/app_text_style.dart';
import 'package:green_fairm/presentation/view/main/news/breaking_news_section.dart';
import 'package:green_fairm/presentation/view/main/news/widget/news_item.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _slidingIndex = 0;
  @override
  Widget build(BuildContext context) {
    // return DefaultTabController(
    //   length: 3, // Số lượng Tabs
    //   child: Scaffold(
    //     body: CustomScrollView(
    //       slivers: [
    //         SliverAppBar(
    //           expandedHeight: 200.0,
    //           pinned: true,
    //           bottom: const TabBar(
    //             tabs: [
    //               Tab(text: 'Tab 1'),
    //               Tab(text: 'Tab 2'),
    //               Tab(text: 'Tab 3'),
    //             ],
    //           ),
    //           flexibleSpace: FlexibleSpaceBar(
    //             title: const Text('Sliver AppBar with Tabs'),
    //             background: Image.asset(
    //               AppImage.profileBackground,
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //         ),
    //         const SliverFillRemaining(
    //           child: TabBarView(
    //             children: [
    //               Center(child: Text('Content for Tab 1')),
    //               Center(child: Text('Content for Tab 2')),
    //               Center(child: Text('Content for Tab 3')),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'News',
          style: AppTextStyle.mediumBold(color: AppColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: BreakingNewsSection(),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSlidingSegmentedControl(
                thumbColor: AppColors.accentColor.withOpacity(0.5),
                children: {
                  0: Text(
                    "For You",
                    style: AppTextStyle.defaultBold(
                        color: _slidingIndex == 0
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                  1: Text(
                    "Hot News",
                    style: AppTextStyle.defaultBold(
                        color: _slidingIndex == 1
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                  2: Text(
                    "Market",
                    style: AppTextStyle.defaultBold(
                        color: _slidingIndex == 2
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                  3: Text(
                    "Plant Health",
                    style: AppTextStyle.defaultBold(
                        color: _slidingIndex == 3
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                },
                onValueChanged: (value) {
                  setState(() {
                    _slidingIndex = value!;
                  });
                },
                groupValue: _slidingIndex,
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                10,
                (index) => NewsItem(
                  index: index,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
