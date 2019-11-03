import 'package:flutter/material.dart';
import 'dart:ui';

class ResponsiveButton extends StatefulWidget {

  Function tapped;
  double width, height;
  Widget child;
  double borderRadius;
  Color highlightedColor;

  ResponsiveButton({this.tapped, this.width, this.height, this.child, this.borderRadius = 0, this.highlightedColor});

  @override
  State<StatefulWidget> createState() {
    return ResponsiveButtonState();
  }

}

class ResponsiveButtonState extends State<ResponsiveButton> {

  bool isPressed = false;

  Color highlightedColor = Color(0x44000000);

  @override void initState() {
    super.initState();

    if (widget.highlightedColor != null) {
      highlightedColor = widget.highlightedColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
        onPanDown: (details) {
          setState(() {
            isPressed = true;
          });
        },
        onPanCancel: () {
          setState(() {
            isPressed = false;
          });
        },
        onPanEnd: (details) {
          setState(() {
            isPressed = false;
          });
        },
        onTap: widget.tapped,
        behavior: HitTestBehavior.translucent,
        child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.borderRadius),
                color: isPressed ? highlightedColor : Colors.transparent,
//                border: Border.all(color: Color(0xFFAAAAAA), width: 1)
            ),
            child: widget.child
        )
    );
  }
}

