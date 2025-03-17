import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scholar_chat/core/assets.dart';
import 'package:scholar_chat/feature/chat/cubit/chat_cubit.dart';

import 'package:scholar_chat/feature/chat/model/model.dart';
import 'package:scholar_chat/feature/chat/presentation/views/widgets/chat_item_widget.dart';

class ChatView extends StatelessWidget {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();


  ChatView({super.key});

  @override
  Widget build(BuildContext context) {
     List<Message> chats = [];
     
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
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  if (state is ChatSuccess) {
                    chats = state.message;
                  }
                },
                builder: (context, state) {
                  return ListView.builder(
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
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                controller: messageController,
                onSubmitted: (data) {
                  BlocProvider.of<ChatCubit>(context).pushMessage(messageController.text);
                  messageController.clear();

                  _scrollController.animateTo(
                    0,
                    curve: Curves.easeIn,
                    duration: const Duration(microseconds: 500),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Type a message? ',
                  border: OutlineInputBorder(),
                  suffixIcon: InkWell(
                    onTap: () {
                      BlocProvider.of<ChatCubit>(context).pushMessage(messageController.text);
                      messageController.clear();

                      _scrollController.animateTo(
                        0,
                        curve: Curves.easeIn,
                        duration: const Duration(microseconds: 500),
                      );
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
  }
}
