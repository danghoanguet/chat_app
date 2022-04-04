// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class Body extends StatelessWidget {
//   const Body({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('chat')
//             .orderBy('createAt', descending: true)
//             .snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
//           return ListView.builder(
//             itemCount: 10,
//             shrinkWrap: true,
//             padding: EdgeInsets.only(top: 16),
//             physics: NeverScrollableScrollPhysics(),
//             itemBuilder: (context, index) {
//               return ConversationList(
//                 name: snapshots[index].name,
//                 messageText: snapshots[index].messageText,
//                 imageUrl: snapshots[index].imageURL,
//                 time: chatUsers[index].time,
//                 isMessageRead: (index == 0 || index == 3) ? true : false,
//               );
//             },
//           );
//         });
//   }
// }

// class ConversationList extends StatefulWidget {
//   String name;
//   String messageText;
//   String imageUrl;
//   String time;
//   bool? isMessageRead;
//   ConversationList(
//       {Key? key,
//       required this.name,
//       required this.messageText,
//       required this.imageUrl,
//       required this.time,
//       this.isMessageRead = false})
//       : super(key: key);
//   @override
//   _ConversationListState createState() => _ConversationListState();
// }

// class _ConversationListState extends State<ConversationList> {
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return Container();
//         }));
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Row(
//                 children: <Widget>[
//                   CircleAvatar(
//                     backgroundImage: NetworkImage(widget.imageUrl),
//                     maxRadius: 30,
//                   ),
//                   SizedBox(
//                     width: 16,
//                   ),
//                   Expanded(
//                     child: Container(
//                       color: Colors.transparent,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             widget.name,
//                             style: TextStyle(fontSize: 16),
//                           ),
//                           SizedBox(
//                             height: 6,
//                           ),
//                           Text(
//                             widget.messageText,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.grey.shade600,
//                                 fontWeight: widget.isMessageRead!
//                                     ? FontWeight.bold
//                                     : FontWeight.normal),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Text(
//               widget.time,
//               style: TextStyle(
//                   fontSize: 12,
//                   fontWeight: widget.isMessageRead!
//                       ? FontWeight.bold
//                       : FontWeight.normal),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
