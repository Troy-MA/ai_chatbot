import 'package:ai_chatbot/models/text_model.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/messeges.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.title});

  final String title;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  MessagesController textsController = Get.put(MessagesController());
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: textsController.texts.length,
                itemBuilder: (context, index) => BubbleSpecialThree(
                  text: textsController.texts[index].text,
                  color: textsController.texts[index].isSender
                      ? Colors.green
                      : Colors.teal,
                  isSender: textsController.texts[index].isSender,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: width * .8,
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 10,
                    ),
                    child: CupertinoTextField(
                      placeholder: "Type message",
                      controller: textController,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async => textsController
                      .sendNewMessage(
                        "1a9SzCOqTJgF4d0X4WXmvfk0mgm2",
                        TextModel(
                          text: textController.text.trim(),
                          isSender: true,
                          time: Timestamp.now(),
                        ),
                      )
                      .then(
                        (value) => textController.clear(),
                      ),
                  icon: const Icon(
                    Icons.send,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
