import 'package:flutter/material.dart';
import 'package:my_first_project/models/chat_message_entity.dart';
import 'package:my_first_project/widgets/picker_image_body.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class ChatInput extends StatefulWidget {

  final Function(ChatMessageEntity) onSubmit;

  const ChatInput({super.key, required this.onSubmit});

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String _selectedImageUrl = '';
  final chatMessageController = TextEditingController();

  void onImagePicked(String newImageUrl) {
    setState(() {
      _selectedImageUrl = newImageUrl;
    });
    Navigator.of(context).pop();
  }

  void onSend() async {
    String username = await context.read<AuthService>().getUsername();
    var newChatMessage = ChatMessageEntity(
        id: '123',
        text: chatMessageController.text,
        createdAt: DateTime
            .now()
            .microsecondsSinceEpoch,
        author: Author(username: username));
    if(_selectedImageUrl.isNotEmpty) {
      newChatMessage.image = _selectedImageUrl;
    }
    widget.onSubmit(newChatMessage);

    chatMessageController.clear();
    _selectedImageUrl = '';
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      // height: 100,
      decoration: BoxDecoration(
        color: Colors.black87,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context){
                return PickerImageBody(
                  onImageSelected: onImagePicked,);
            });
          }, icon: Icon(Icons.add, color: Colors.white,)),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              minLines: 1,
                              textCapitalization: TextCapitalization.sentences, // to make first letter of sentence big
                              controller: chatMessageController,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                  hintText: 'Type your message',
                  hintStyle: TextStyle(color: Colors.white24),
                  border: InputBorder.none,
                              ),
                            ),
                  if(_selectedImageUrl.isNotEmpty)
                    Image.network(_selectedImageUrl, width: 50,)
                ],
              )),
          IconButton(onPressed: () {onSend();}, icon: Icon(Icons.send, color: Colors.white,))
        ],
      ),
    );
  }


}