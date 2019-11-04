import 'package:flutter/material.dart';

class CommentBox extends StatefulWidget {
  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.face,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[Text("User Name")],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("Comment Text"),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up),
                    Icon(Icons.thumb_down),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
