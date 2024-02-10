import 'dart:developer';

import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String? name;
  String? icon;
  @override
  void didChangeDependencies() {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;
    final String name_arg = args['name'];
    final String icon_arg = args['icon'];
    name = name_arg;
    icon = icon_arg;

    setState(() {});
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(18, 0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: Transform.translate(
          offset: const Offset(-15, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset(
                  icon!,
                  height: 50,
                  width: 50,
                ),
                title: Text(
                  name!,
                ),
                subtitle: Text("В Сети"),
              )
            ],
          ),
        ),
        centerTitle: false,
      ),
    );
  }
}
