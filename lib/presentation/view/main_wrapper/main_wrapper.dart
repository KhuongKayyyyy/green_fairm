import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:green_fairm/presentation/view/main_wrapper/widget/ai_mini_chatbox.dart';
import 'package:green_fairm/presentation/view/main_wrapper/widget/app_bottom_navigation_bar.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;
  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: widget.navigationShell,
        ),
        bottomNavigationBar: Stack(
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AppBottomNavigationBar(widget: widget)),
            const Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Center(child: AiMiniChatbox()),
            ),
          ],
        ));
  }
}
