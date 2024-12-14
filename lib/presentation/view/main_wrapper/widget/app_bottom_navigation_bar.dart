import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final dynamic widget;
  const AppBottomNavigationBar({super.key, required this.widget});

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: FlashyTabBar(
        backgroundColor: Colors.white,
        selectedIndex: _selectedIndex,
        showElevation: true,
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
          _onTabTapped(index, widget.widget);
        }),
        items: [
          FlashyTabBarItem(
            inactiveColor: AppColor.grey,
            activeColor: AppColor.primaryColor,
            icon: const Icon(CupertinoIcons.home),
            title: const Text('Home'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColor.grey,
            activeColor: AppColor.primaryColor,
            icon: const Icon(CupertinoIcons.news),
            title: const Text("News"),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColor.grey,
            activeColor: AppColor.primaryColor,
            icon: const Icon(CupertinoIcons.news),
            title: const Text("Padding"),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColor.grey,
            activeColor: AppColor.primaryColor,
            icon: const Icon(CupertinoIcons.tree),
            title: const Text('Highlights'),
          ),
          FlashyTabBarItem(
            inactiveColor: AppColor.grey,
            activeColor: AppColor.primaryColor,
            icon: const Icon(CupertinoIcons.person),
            title: const Text('Profile'),
          ),
          // FlashyTabBarItem(
          //   icon: Icon(Icons.settings),
          //   title: Text('한국어'),
          // ),
        ],
      ),
    );
  }

  void _onTabTapped(int index, dynamic widget) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }
}
