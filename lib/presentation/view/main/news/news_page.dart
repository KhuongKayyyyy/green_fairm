import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_image.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Số lượng Tabs
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              pinned: true,
              bottom: const TabBar(
                tabs: [
                  Tab(text: 'Tab 1'),
                  Tab(text: 'Tab 2'),
                  Tab(text: 'Tab 3'),
                ],
              ),
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Sliver AppBar with Tabs'),
                background: Image.asset(
                  AppImage.profileBackground,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  Center(child: Text('Content for Tab 1')),
                  Center(child: Text('Content for Tab 2')),
                  Center(child: Text('Content for Tab 3')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
