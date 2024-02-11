import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger_flutter_project/core/consts/theme.dart';
import 'package:messenger_flutter_project/core/widgets/chat_tile.dart';
import 'package:messenger_flutter_project/features/data/models/message.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final List<String> names = [
    'Виктор Власов',
    'Саша Алексеев',
    'Пётр Жаринов',
    'Алина Жукова',
  ];
  final List<String> images = [
    AppIcons.viktorVlasov,
    AppIcons.sashaAlekseev,
    AppIcons.petrZharinov,
    AppIcons.alinaZhukova,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Чаты', style: TextStyle(fontSize: 32.0)),
            10.h,
            TextField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  hintText: "Поиск",
                  hintStyle:
                      TextStyle(fontSize: 16.0, color: Color(0xff9DB7CB)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Container(
                    padding: EdgeInsets.all(9),
                    child: SvgPicture.asset(
                      AppIcons.search,
                      color: Color(0xff9DB7CB),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xff9DB7CB).withOpacity(0.2)),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Divider(),
          ListView.separated(
            shrinkWrap: true,
            itemCount: 4,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, i) {
              return FutureBuilder<Message?>(
                future: getLastMessage(
                    names[i]),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return ChatTile(
                          name: names[i],
                          icon: images[i],
                          lastMessage: snapshot.data);
                    } else if (snapshot.hasError) {
                      return Text('Ошибка: ${snapshot.error}');
                    } else {
                      return ChatTile(
                          name: names[i], icon: images[i], lastMessage: null);
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<Message?> getLastMessage(String name) async {
  CollectionReference collection = FirebaseFirestore.instance.collection(name);

  QuerySnapshot querySnapshot = await collection.get();
  Map lastMes = querySnapshot.docs.last.data() as Map;
  if (lastMes.isNotEmpty) {
    String text = lastMes['text'];
    Timestamp timestamp = lastMes['dateofmessage'];
    bool isSentByMe = lastMes['isSentByMe'];

    // Преобразование Timestamp в DateTime
    DateTime dateOfMessage = timestamp.toDate();
    Message lastMessage = Message(
        text: text, isSentByMe: isSentByMe, dateofmessage: dateOfMessage);
    return lastMessage;
  } else {
    log('No message');
    return null;
  }
}
