import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_loading_indicator.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/app_text.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/main_app_bar.dart';
import '../../Core/dio/api_provider.dart';
import '../../Widgets/snack_bar.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController _controller = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, String>> messages = [
    {"sender": "bot", "message": "Hi mom, how can I help you today?"},
  ];
  bool isLoading = false;

  void sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "message": _controller.text});
        isLoading = true;
      });

      final userMessage = _controller.text;
      _controller.clear();

      final botResponse = await _apiProvider.sendChatMessage(userMessage);

      setState(() {
        isLoading = false;
        if (botResponse.contains("Failed") || botResponse.contains("No token")) {
          showSnackBar(botResponse, error: true);
        } else {
          messages.add({"sender": "bot", "message": botResponse});
        }
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const MainAppBar(
        title: "Supported Chat",
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 28.h,
          right: 20.w,
          left: 20.w,
          bottom: 7.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length + (isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (isLoading && index == messages.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: AppLoadingIndicator(),
                      ),
                    );
                  }
                  bool isUser = messages[index]["sender"] == "user";
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: isUser
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
                    children: [
                      if (!isUser)
                        Image.asset(
                          "Assets/Images/robot.png",
                        ),
                      SizedBox(
                        width: 9.49.w,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isUser ? AppColors.grey : AppColors.pinkLight,
                            borderRadius: isUser
                                ? const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            )
                                : const BorderRadius.only(
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                          child: AppText(
                            title: messages[index]["message"]!,
                            color: Colors.black,
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 52.h,
                    width: 283.w,
                    padding: EdgeInsets.symmetric(horizontal: 18.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.grey,
                    ),
                    child: TextField(
                      controller: _controller,
                      enabled: !isLoading,
                      decoration: const InputDecoration(
                        hintText: "Type a message to chat",
                        hintStyle: TextStyle(
                          color: AppColors.greyLight,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto",
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: isLoading ? null : sendMessage,
                  child: Container(
                    height: 53.h,
                    width: 53.w,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: AppColors.primaryG),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image.asset('Assets/Images/send.png'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


