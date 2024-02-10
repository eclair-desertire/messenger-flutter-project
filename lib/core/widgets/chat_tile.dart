import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final String name;
  final String icon;

  const ChatTile({super.key, required this.name, required this.icon});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.asset(
        widget.icon,
        height: 50,
        width: 50,
      ),
      title: Text(
        widget.name,
      ),
      onTap: () {
        Navigator.of(context).pushNamed(
          '/chat',
          arguments: widget.name,
        );
      },
    );
  }
}
