import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createAt', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshots.data!.docs;
        return ListView.builder(
            // scroll the view reverse (from bottom to top) default is top to bottom
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, index) => MessageBubble(
                  message: chatDocs[index]['text'],
                  isMe: chatDocs[index]['userId'] == user.uid,
                  key: ValueKey(chatDocs[index].id),
                ));
      },
    );
  }
}
