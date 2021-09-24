import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './chat_bubble.dart';

class Messages extends StatelessWidget {
  // const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatDocs = chatSnapshot.data.documents;

                return ListView.builder(
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (ctx, index) => ChatBubble(
                    message:chatDocs[index]['text'],
                    isMe:chatDocs[index]['userId'] == futureSnapshot.data.uid,
                    key:ValueKey(chatDocs[index].documentID),//we have included the keys so that the flutter will not have issues in rerendering and updating list 
                    username: chatDocs[index]['username'],
                    userImage: chatDocs[index]['userImage'],
                  ),
                );
              });
        });
  }
}
