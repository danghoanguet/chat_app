import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({Key? key}) : super(key: key);

  @override
  State<NewMessages> createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _enterdMessage = '';
  final _controller = TextEditingController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final uid = await FirebaseAuth.instance.currentUser!.uid;
    final userData =
        await FirebaseFirestore.instance.collection('users').doc('$uid').get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _enterdMessage,
      'createAt': Timestamp.now(),
      'userId': uid,
      'userName': userData['username'],
      'userImageUrl': userData['userImageUrl'],
    });

    _controller.clear();
    _enterdMessage = _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(
      //   top: 8,
      // ),
      //padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
            child: TextField(
          controller: _controller,
          decoration: InputDecoration(labelText: 'Send a message...'),
          onChanged: (val) {
            setState(() {
              _enterdMessage = val;
            });
          },
        )),
        IconButton(
          onPressed:
              _enterdMessage.trim() == '' || _enterdMessage.trim().isEmpty
                  ? null
                  : _sendMessage,
          icon: Icon(Icons.send),
          color: Theme.of(context).colorScheme.primary,
        )
      ]),
    );
  }
}
