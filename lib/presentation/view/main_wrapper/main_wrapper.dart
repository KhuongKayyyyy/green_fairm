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
        resizeToAvoidBottomInset: false,
        extendBody: true,
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.only(bottom: 80),
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
            Positioned(
                bottom: 90,
                left: 0,
                right: 0,
                child: Container(
                  height: 15,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.3),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter)),
                )),
          ],
        ));
  }
}
