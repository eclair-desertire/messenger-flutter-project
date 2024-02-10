import 'package:messenger_flutter_project/features/presentation/chat/chat.dart';
import 'package:messenger_flutter_project/features/presentation/chat/chat_list.dart';

final appRoutes = {
  '/': (context) => ChatList(),
  '/chat': (context) => Chat(),
};
