import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:green_fairm/presentation/view/chat/chat_page.dart';

class AiMiniChatbox extends StatelessWidget {
  const AiMiniChatbox({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showChatboxBottomSheet(context),
      child: Hero(
        tag: 'chatbox',
        child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.primaryColor, AppColor.secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.4),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: const Icon(CupertinoIcons.rocket, color: Colors.white),
        ),
      ),
    );
  }

  void _showChatboxBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (BuildContext context) {
        return const ChatPage();
      },
    );
  }
}
