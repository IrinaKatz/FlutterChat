import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_first_project/models/chat_message_entity.dart';
import 'package:my_first_project/services/auth_service.dart';
import 'package:my_first_project/widgets/chat_bubble.dart';
import 'package:my_first_project/widgets/chat_input.dart';
import 'package:provider/provider.dart';

// stl - to create stateless class
// stful to create stateful

class ChatPage extends StatefulWidget {

  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatMessageEntity> _messages = [];

  _loadInitialMessages() async {
    final response = await rootBundle.loadString('assets/mock_messages.json'); // other way - to use .then((response){...} instead of async/await
    final List<dynamic> decodedList = jsonDecode(response) as List;
    final List<ChatMessageEntity> _chatMessages = decodedList.map((listMessage){
      return ChatMessageEntity.fromJson(listMessage);
    }).toList();

    setState(() {
      _messages = _chatMessages;
    });
  }

  onMessageSent(ChatMessageEntity entity) {
    _messages.add(entity);
    setState(() {

    });
  }

  Future<String> getUsername(context) async {
    return await context.read<AuthService>().getUsername();
  }

  @override
  void initState() {
    _loadInitialMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = context.read<AuthService>();
    final String _username = context.watch<AuthService>().getUsername();

          return Scaffold(
            appBar:
            AppBar(
              backgroundColor: Colors.yellow,
              title: Center(child: Text('Hi $_username')),
              actions: [
                IconButton(onPressed: () {
                  _authService.logoutUser();
                  Navigator.pushReplacementNamed(context, '/');
                }, icon: Icon(Icons.logout),)
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        alignment: _messages[index].author.username ==
                            _username ? Alignment.centerRight : Alignment
                            .centerLeft,
                        messageEntity: _messages[index],);
                    },
                  ),
                ),
                ChatInput(onSubmit: onMessageSent,)
              ],
            ),
          );
  }
}