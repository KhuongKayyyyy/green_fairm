import 'dart:developer';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:green_fairm/core/constant/app_color.dart';
import 'package:image_picker/image_picker.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];
  final User user = FirebaseAuth.instance.currentUser!;
  late final ChatUser chatUser;
  final ChatUser geminiUser = ChatUser(
      id: 'gemini',
      lastName: 'Gemini',
      profileImage:
          "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Google_Gemini_logo.svg/1200px-Google_Gemini_logo.svg.png");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatUser = ChatUser(
      id: user.uid,
      lastName: user.displayName!,
      profileImage: user.photoURL!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'chatbox',
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          AppColor.primaryColor,
                          AppColor.secondaryColor
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child:
                        const Icon(CupertinoIcons.rocket, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20),
                const Text(
                  'Green Fairm Chatbox',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            _buildChat(),
          ],
        ),
      ),
    );
  }

  Widget _buildChat() {
    return Expanded(
      child: DashChat(
          messageOptions: MessageOptions(
            containerColor: Colors.grey[200]!,
            textColor: AppColor.secondaryColor,
            borderRadius: 10,
            messageMediaBuilder:
                (currentMessage, previousMessage, nextMessage) {
              if (currentMessage.medias != null &&
                  currentMessage.medias!.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var media in currentMessage.medias!)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            File(media.url).readAsBytesSync(),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ],
                );
              }

              // Return a placeholder or empty container if no media exists
              return const SizedBox.shrink();
            },
          ),
          inputOptions: InputOptions(trailing: [
            IconButton(
              icon: const Icon(
                CupertinoIcons.photo,
                color: AppColor.primaryColor,
              ),
              onPressed: _sendMediaMessage,
            ),
          ]),
          currentUser: chatUser,
          onSend: _sendMessage,
          messages: messages),
    );
  }

  void _sendMessage(ChatMessage message) async {
    setState(() {
      messages = [message, ...messages];
    });

    try {
      String messageText = message.text;
      List<Uint8List> medias = [];

      // Check if there are media files
      if (message.medias != null && message.medias!.isNotEmpty) {
        for (var media in message.medias!) {
          // Verify the file exists and read as bytes
          try {
            final fileBytes = File(media.url).readAsBytesSync();
            medias.add(fileBytes);
          } catch (e) {
            print("Error reading file: ${media.url}, Error: $e");
          }
        }
      }

      // Start streaming the response
      gemini.promptStream(
        parts: [
          Part.text(messageText),
          if (medias.isNotEmpty) Part.bytes(medias.first),
        ],
      ).listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event!.output ?? "No response";
          lastMessage.text += " $response";
          setState(() {
            messages = [lastMessage!, ...messages];
          });
        } else {
          String response = event!.output ?? "No response";
          ChatMessage newMessage = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [newMessage, ...messages];
          });
        }
      });
    } catch (e) {
      print("Error in _sendMessage: $e");
    }
  }

  void _sendMediaMessage() async {
    ImagePicker imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      ChatMessage message = ChatMessage(
          user: chatUser,
          createdAt: DateTime.now(),
          medias: [
            ChatMedia(url: image.path, fileName: "", type: MediaType.image)
          ],
          text: "Describe the picture");
      _sendMessage(message);
    }
  }
}
