import 'package:flutter/material.dart';
import 'package:my_first_project/models/chat_message_entity.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class ChatBubble extends StatelessWidget {

  final ChatMessageEntity messageEntity;
  final Alignment alignment;

  Future<String> getUsername(context) async {
    return await context.read<AuthService>().getUsername();
  }

  const ChatBubble({super.key, required this.messageEntity, required this.alignment});

  @override
  Widget build(BuildContext context) {
    final String _username = context.watch<AuthService>().getUsername();

          return Align(
            alignment: alignment,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${messageEntity.text}', style: TextStyle(
                      fontSize: 20
                  ),),
                  if(messageEntity.image != null)
                    Container(
                        height: 100,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(messageEntity.image!)),
                            borderRadius: BorderRadius.circular(20))
                    )
                ],
              ),
              constraints: BoxConstraints(maxWidth: MediaQuery
                  .of(context)
                  .size
                  .width * 0.6),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: _username == messageEntity.author.username
                      ? Colors.blue
                      : Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))
              ),
            ),
          );

  }

}