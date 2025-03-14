import 'package:scholar_chat/core/strings.dart';

class Message {
  final String message;
  final String email;

  Message(this.message, this.email);

  factory Message.formJson(json) {
    return Message(json[kChatKey],json[kEmailKey]);
  }
}
