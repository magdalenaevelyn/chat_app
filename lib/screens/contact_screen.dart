import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/screens/chat_screen.dart';

class ContactScreen extends StatelessWidget {

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

          return StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chat-user')
                  .snapshots(),
              builder: (ctx, streamSnapshot) {
                if (streamSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final docs = streamSnapshot.data.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    if (docs[index]['userId'] != snapshot.data.uid) {
                      return ListTile(
                        leading: CircleAvatar(backgroundImage: NetworkImage(docs[index]['imageUrl']),),
                        title: Text(docs[index]['username']),
                        subtitle: Text('E-mail ' + docs[index]['email']),
                        trailing: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChatScreen(docs[index]['username'])
                              )
                            );
                          },
                          child: Text(
                            'Message',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Text('');
                    }
                  }
                );
              });
        });
  }
}
