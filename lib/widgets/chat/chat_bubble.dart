import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class ChatBubble extends StatelessWidget {
  // const ChatBubble({Key? key}) : super(key: key);
  ChatBubble({
    this.message,
    this.isMe,
    this.key,
    this.username,
    this.userImage,
  });

  final Key key;
  final String message;
  final bool isMe;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Colors.grey[300]
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                ),
              ),
              width: 140,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: !isMe?CrossAxisAlignment.start:CrossAxisAlignment.end,
                children: [
                  Text(username,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).colorScheme.secondary)),
                  Text(message,
                      style: TextStyle(
                          color: isMe
                              ? Colors.black
                              : Theme.of(context).colorScheme.secondary)),
                  // textAlign: isMe ? TextAlign.end : TextAlign.start,
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
