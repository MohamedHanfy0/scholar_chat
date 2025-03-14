import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/core/strings.dart';
import 'package:scholar_chat/feature/home/model/model.dart';
import 'package:scholar_chat/feature/home/presentation/views/widgets/chat_item_widget.dart';

class HomeView extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final CollectionReference message = FirebaseFirestore.instance.collection(
    kMessage,
  );

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: message.orderBy(kCreatedAtKey, descending: true).snapshots(),

      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<Message> chats = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            chats.add(Message.formJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[900],
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 10,
                children: [
                  Image.asset(
                    Assets.assetsIconsMortarboard,
                    width: 40,
                    height: 40,
                  ),
                  Text(
                    "Chat Group",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    context.replace('/login');
                  },
                  child: Icon(Icons.logout_outlined),
                ),
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      reverse: true,
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return ChatItemWidget(
                          text: chats[index].message,
                          leftTrue:
                              chats[index].email ==
                                      FirebaseAuth.instance.currentUser!.email
                                  ? true
                                  : false,
                          email: chats[index].email,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: TextField(
                      controller: messageController,
                      onSubmitted: (data) {
                        pushMessage(data);
                      },
                      decoration: InputDecoration(
                        hintText: 'Type a message? ',
                        border: OutlineInputBorder(),
                        suffixIcon: InkWell(
                          onTap: () {
                            pushMessage(messageController.text);
                          },
                          child: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  void pushMessage(String data) {
    message.add({
      kChatKey: data,
      kCreatedAtKey: DateTime.now(),
      kEmailKey: FirebaseAuth.instance.currentUser!.email,
    });
    messageController.clear();

    _scrollController.animateTo(
      0,
      curve: Curves.easeIn,
      duration: const Duration(microseconds: 500),
    );
  }
}
