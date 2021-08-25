import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class ChatListScreen extends StatelessWidget {
  static const routeName = 'chat-list-screen';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .where('createdAt', isLessThan: Timestamp.now())
                .snapshots(),
            builder: (ctx, streamSnapshot) {
              if (streamSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final chatDocs = streamSnapshot.data.docs;
              return ListView.builder(
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) {
                    if (chatDocs[index]['userId'] != snapshot.data.uid) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              NetworkImage(chatDocs[index]['userImage']),
                        ),
                        title: Text(chatDocs[index]['username']),
                        subtitle: Text(chatDocs[index]['messageText']),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChatScreen(
                                  chatDocs[index]['username'],
                              )
                            )
                          );
                        },
                      );
                    } else {
                      return Text('a');
                    }
                  }
                );
            });
      },
    );
  }
}
