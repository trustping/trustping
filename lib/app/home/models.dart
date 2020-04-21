import 'package:flutter/foundation.dart';

class Message {
  Message({@required this.id, @required this.author, @required this.body});
  String id;
  String author;
  String body;
  // DateTime createdAt;

  factory Message.fromMap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    return Message(
      id: documentId,
      author: data["author"],
      body: data["body"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author': author,
      'body': body,
    };
  }
}

class Chat {
  Chat({
    @required this.id,
    @required this.participants,
    @required this.messages,
  });
  String id;
  List<String> participants;
  List<Message> messages;
  // DateTime createAt;

  String otherParticipant(String myUserID) {
    return participants.where((p) => p != myUserID).toList()[0];
  }

  factory Chat.fromMap(Map<String, dynamic> data, String documentID) {
    assert(data["participants"] != null);
    final List<String> _participants = List.from(data["participants"]);
    return Chat(
      id: documentID,
      participants: _participants,
      messages: <Message>[],
      // messages: data["messages"].map((item) => Message.fromMap(item)).toList()),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "participants": participants,
    };
  }
}
