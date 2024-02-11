import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:messenger_flutter_project/core/consts/theme.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final TextEditingController _controller = TextEditingController();

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
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 44, horizontal: 20),
        color: Colors.white,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff9DB7CB).withOpacity(0.2),
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
                  color: Color(0xff9DB7CB).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: _controller,
                  onSubmitted: (value) {
                    _controller.clear();
                  },
                  decoration: InputDecoration(
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
                color: Color(0xff9DB7CB).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  AppIcons.audio,
                  color: Colors.black,
                ),
                onPressed: () {
                  // TODO: Добавить логику для записи аудио
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
