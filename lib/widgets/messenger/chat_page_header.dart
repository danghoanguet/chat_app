import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreenHeader extends StatelessWidget {
  final String imageUrl;
  const ChatScreenHeader({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                      width: 2, color: Theme.of(context).primaryColor)),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                maxRadius: 25,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Chats",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
          ],
        ),
        DropdownButton(
            underline: SizedBox(),
            icon: Icon(
              Icons.more_vert,
              color: Colors.pink,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.pink),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') FirebaseAuth.instance.signOut();
            })
      ],
    );
  }
}
