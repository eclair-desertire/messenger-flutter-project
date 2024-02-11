import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:messenger_flutter_project/core/consts/theme.dart';
import 'package:messenger_flutter_project/features/data/models/message.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();
  List<Message> messages = [];

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
    readMessages(name!).then((newMessages) {
      setState(() {
        messages = newMessages;
      });
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: const Offset(18, 0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
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
                subtitle: const Text("В Сети"),
              )
            ],
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        reverse: true,
        itemCount: messages.length,
        itemBuilder: (context, i) {
          final Message message = messages[i];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            alignment: message.isSentByMe
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: message.isSentByMe
                    ? const Color(0xff3CED78)
                    : Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: IntrinsicWidth(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        message.text,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        DateFormat('HH:mm').format(message.dateofmessage),
                        style:
                            const TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 20),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff9DB7CB).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  AppIcons.attach,
                  color: Colors.black,
                ),
                onPressed: () {
                  // TODO: Добавить логику для прикрепления изображения
                },
              ),
            ),
            8.w,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff9DB7CB).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    writeData(name!, _controller.text);
                    readMessages(name!).then((newMessages) {
                      setState(() {
                        messages = newMessages;
                      });
                    });
                    _controller.clear();
                  },
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: "Сообщение",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            8.w,
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff9DB7CB).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  AppIcons.audio,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<List<Message>> readMessages(String name) async {
  CollectionReference collection = FirebaseFirestore.instance.collection(name);
  List<Message> newMessages = [];

  QuerySnapshot querySnapshot =
      await collection.orderBy('dateofmessage', descending: true).get();
  for (var doc in querySnapshot.docs) {
    var data = doc.data() as Map<String, dynamic>;
    if (data.isEmpty) {
      return newMessages;
    }
    Message message = Message(
      text: data['text'],
      isSentByMe: data['isSentByMe'],
      dateofmessage: (data['dateofmessage'] as Timestamp).toDate(),
    );
    newMessages.add(message);
  }
  return newMessages;
}

Future<void> writeData(String name, String text) async {
  CollectionReference collection = FirebaseFirestore.instance.collection(name);

  await collection.add({
    'text': text,
    'isSentByMe': true,
    'dateofmessage': Timestamp.now(),
  });
}
