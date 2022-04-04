import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'auth_screen.dart';
import 'chat_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          final uid = snapshot.data!.uid;
          return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc('$uid')
                  .get(),
              builder: (context,
                  AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> ss) {
                if (ss.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (ss.hasData)
                  return ChatScreen(
                    userImageUrl: ss.data!['userImageUrl'],
                    uid: uid,
                  );
                return Center(
                  child: CircularProgressIndicator(),
                );
              });
        }
        return AuthScreen();
      },
    );
  }
}
