import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';

@freezed
abstract class Chat implements _$Chat {
  const Chat._();
  const factory Chat({
    String id,
    List<String> participants,
  }) = _Chat;

  String otherParticipant(String myUserID) {
    return participants.where((p) => p != myUserID).toList()[0];
  }

  factory Chat.fromMap(Map<String, dynamic> data, String documentID) {
    assert(data["participants"] != null);
    final List<String> _participants =
        List.from(data["participants"]).cast<String>();
    return Chat(
      id: documentID,
      participants: _participants,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "participants": participants,
    };
  }
}
