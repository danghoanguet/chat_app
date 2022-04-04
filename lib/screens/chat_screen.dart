import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chat/message_bubble.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_messages.dart';
import '../widgets/messenger/chat_page_header.dart';
import '../widgets/messenger/conversationList.dart';
import '../widgets/messenger/search_bar.dart';

class ChatScreen extends StatefulWidget {
  final String uid;
  final String userImageUrl;
  const ChatScreen({Key? key, required this.uid, required this.userImageUrl})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _listUsers = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _searchedUser = [];
  List<String> usersName = [];

  void _searchUsers(String userName) {
    setState(() {
      _searchedUser = _listUsers
          .where((element) => containIgnoreCase(userName, element['username']))
          .toList();
    });
  }

  bool containIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('users').get(),
        //FirebaseFirestore.instance.collection('users').doc('$uid').get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          _listUsers = snapshot.data!.docs;
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ChatScreenHeader(
                      imageUrl: widget.userImageUrl,
                    ),
                    SearchBar(
                      onSearch: (userName) => _searchUsers(userName),
                    ),
                    Expanded(
                      child: ListView(
                        children: _searchedUser
                            .map((e) => ConversationList(
                                  imageUrl: e['userImageUrl'],
                                  messageText: '',
                                  name: e['username'],
                                  time: '',
                                ))
                            .toList(),
                      ),
                    ),
                    NewMessages(),
                    //ListViewChats(chatUsers: chatUsers)
                  ],
                ),
              ),
              // bottomNavigationBar: BottomNavigationBar(
              //   selectedItemColor: Colors.pink,
              //   unselectedItemColor: Colors.grey.shade600,
              //   selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              //   unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              //   type: BottomNavigationBarType.fixed,
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.message),
              //       // ignore: deprecated_member_use
              //       label: "Chats",
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.group_work),
              //       // ignore: deprecated_member_use
              //       label: "Channels",
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.account_box),
              //       // ignore: deprecated_member_use
              //       label: "Profile",
              //     ),
              //   ],
              // ),
            ),
          );
        });
  }
}
