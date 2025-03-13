import 'package:flutter/material.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/feature/home/presentation/views/widgets/chat_item_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset(Assets.assetsIconsMortarboard, width: 40, height: 40),
            Text(
              "Chat Group",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return ChatItemWidget(text: 'hello', leftTrue: true);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message? ',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.send),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
