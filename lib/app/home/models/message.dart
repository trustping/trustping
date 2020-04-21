import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
abstract class Message implements _$Message {
  const Message._();
  const factory Message({
    String id,
    String author,
    String body,
  }) = _Message;

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
