import 'package:flutter/material.dart';
import 'package:smart_cradle_for_baby_care_app/Core/app_colors/app_colors.dart';
import 'package:smart_cradle_for_baby_care_app/Widgets/secondary_app_bar.dart';
import '../../Core/route_utils/route_utils.dart';

  class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
  }

  class _ChatBotViewState extends State<ChatBotView> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [
    {"sender": "bot", "message": "Hi mom, how can I help you today?"},
  ];

  void sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add({"sender": "user", "message": _controller.text});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.white,
     appBar: SecondaryAppBar(
        title: "Chat Bot",
        onTap: () {
          RouteUtils.pop();
        },
       ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.grey[200] : Colors.pink[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      messages[index]["message"]!,
                      style: const TextStyle(color: Colors.black,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Send something",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon:  Icon(Icons.send, color: AppColors.primaryColor2),
                  onPressed: sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


