import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String userImage;

  Bubble(this.message, this.username, this.userImage, this.isMe, {this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isMe)
            SizedBox(width: 8,),
            if (!isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(userImage),
            ),
            Container(
              decoration: BoxDecoration(
                color: isMe ? Colors.grey[300] : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                  bottomRight: isMe? Radius.circular(0) : Radius.circular(12)
                ),
              ),
              width: 200,
              padding: EdgeInsets.symmetric(
                vertical: 8, 
                horizontal: 10
              ),
              margin: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 8
              ),
              child: Column(
                crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.black
                    ),
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
      clipBehavior: Clip.none
    );
  }
}
