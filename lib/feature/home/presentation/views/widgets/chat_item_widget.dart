import 'package:flutter/material.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({
    super.key,
    required this.text,
    required this.leftTrue,
    required this.email,
  });
  final String text;
  final String email;
  final bool leftTrue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: leftTrue ? 80 : 0,
        left: leftTrue ? 0 : 80,
        top: 8,
        bottom: 8,
      ),
      child: Column(
        spacing: 10,
        children: [
          Align(
            alignment: leftTrue ? Alignment.centerLeft : Alignment.centerRight,
            child: Text(
              email,
              style: TextStyle(
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.blue,
                    blurRadius: 10,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: leftTrue ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // alignment: Alignment.center,
              // width: double.nan,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomRight:
                      leftTrue ? Radius.circular(50) : Radius.circular(0),
                  bottomLeft:
                      leftTrue ? Radius.circular(0) : Radius.circular(50),
                ),
                color: leftTrue ? Colors.amber : Colors.blueGrey[900],
              ),
              child: Text(
                text,
                style: TextStyle(color: leftTrue ? Colors.black : Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
