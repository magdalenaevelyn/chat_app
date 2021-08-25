import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _newMessage = '';

  void _sendNewMessage() async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final data = await FirebaseFirestore.instance
      .collection('chat-user')
      .doc(user.uid)
      .get();

    FirebaseFirestore.instance.collection('chat').add({
      'userId': user.uid,
      'messageText': _newMessage,
      'createdAt': Timestamp.now(),
      'username': data['username'],
      'userImage': data['imageUrl']
    });

    _controller.clear();

    showNotification(_newMessage, data['username']);
  }

  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher')
    );

    _notificationsPlugin.initialize(initializationSettings);
  }

  Future showNotification(String messageText, String username) async {
    var androidDetail = new AndroidNotificationDetails(
      'chatapp', 
      'Local push notification', 
      'Description for local push notif',
      importance: Importance.high
    );

    var generalNotificationDetails = new NotificationDetails(android: androidDetail);

    await _notificationsPlugin.show(
      0, 
      username, 
      messageText, 
      generalNotificationDetails
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'type a message...'),
              onChanged: (value) {
                setState(() {
                  _newMessage = value;
                });
              },
              controller: _controller,
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              color: Theme.of(context).primaryColor,
              onPressed: _newMessage.trim().isEmpty
                ? null
                : _sendNewMessage,
            )
        ],
      ),
    );
  }
}
