import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/message/bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.value(FirebaseAuth.instance.currentUser),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final docs = snapshot.data.docs;
                return ListView.builder(
                    reverse: true,
                    itemCount: docs.length,
                    itemBuilder: (ctx, index) => Bubble(
                        docs[index]['messageText'],
                        docs[index]['username'],
                        docs[index]['userImage'],
                        docs[index]['userId'] == futureSnapshot.data.uid,
                        // key: ValueKey(docs[index].documentID)
                        ));
              });
        });
  }
}
