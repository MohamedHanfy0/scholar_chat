import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:scholar_chat/core/strings.dart';

import 'package:scholar_chat/feature/chat/model/model.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference message = FirebaseFirestore.instance.collection(kMessage);

  Future<void> pushMessage(String data) async {
   await  message.add({
      kChatKey: data,
      kCreatedAtKey: DateTime.now(),
      kEmailKey: FirebaseAuth.instance.currentUser!.email,
    });
    
  }
  Future<void> getMessage() async {
     message.orderBy(kCreatedAtKey, descending: true).snapshots().listen((
      event,
    ) {
      List<Message> messageList = [];
      for (var doc in event.docs) {
        messageList.add(Message.formJson(doc));
      }
      emit(ChatSuccess(message: messageList));
    });
  }
}
