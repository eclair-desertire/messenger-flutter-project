import 'package:flutter/material.dart';
import 'package:messenger_flutter_project/features/data/models/message.dart';

class ChatTile extends StatefulWidget {
  final String name;
  final String icon;
  final Message? lastMessage;

  const ChatTile(
      {super.key, required this.name, required this.icon, this.lastMessage});

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    RichText subtitleObj = RichText(
      text: TextSpan(
        style: TextStyle(
            fontSize: 12,
            color: theme.textTheme.titleMedium?.color ??
                Colors.black), // Применяем цвет по умолчанию из темы
        children: [
          if (widget.lastMessage?.isSentByMe == true)
            const TextSpan(
              text: "Вы: ",
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          TextSpan(
            text: widget.lastMessage?.text ?? '',
          ),
        ],
      ),
    );

    return ListTile(
      leading: Image.asset(
        widget.icon,
        height: 50,
        width: 50,
      ),
      title: Text(
        widget.name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: subtitleObj,
      onTap: () {
        Navigator.of(context).pushNamed(
          '/chat',
          arguments: {'name': widget.name, 'icon': widget.icon},
        );
      },
    );
  }
}
