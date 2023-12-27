class ChatMessageEntity {
  String id;
  String text;
  String? image;
  int createdAt;
  Author author;

  ChatMessageEntity({required this.id, required this.text, this.image, required this.createdAt, required this.author});

  factory ChatMessageEntity.fromJson(Map<String, dynamic> json){
    return ChatMessageEntity(
        id: json['id'],
        text: json['text'],
        image: json['image'],
        createdAt: json['createdAt'],
        author: Author.fromJson(json['author']));
  }
}

class Author {
  String username;

  Author({required this.username});

  factory Author.fromJson(Map<String, dynamic> json){
    return Author(username: json['username']);
  }
}