import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/message/messages.dart';
import 'package:flutter_chat_app/widgets/message/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  ChatScreen(this.username);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.username),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}
