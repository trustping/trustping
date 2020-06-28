import 'dart:convert';

import 'package:trust_ping_app/app/home/models/chat.dart';
import 'package:trust_ping_app/app/home/models/message.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:crypto/crypto.dart';

/// A class representing the initial contact ping to other users.
class PingViewModel {
  final UserProfile userProfile;
  final FirestoreDatabase db;
  PingViewModel({this.userProfile, this.db});

  bool useName = true;
  bool useYearOfBirth = true;
  bool useInterests = true;
  bool useCircumstances = true;
  bool useTherapy = true;
  bool useCancer = true;

  get nameSentence => 'Name: Stefan';
  get yearOfBirthSentence => 'Jahrgang: 1985';
  // get yearOfBirthSentence => 'Jahrgang: *${userProfile.yearOfBirth}*.';
  get cancerTypeSentence => 'Krebstype: Hautkrebs.';
  get therapySentence => 'Therapy: Operation.';
  get interestSentence => 'Interessen: *${userProfile.interests.join(", ")}*.';
  get circumstancesSentence => 'Situation: keine Kinder';

  String compose(String customMessage) {
    List<String> result = [
      "\n",
      if (useName) nameSentence,
      if (useYearOfBirth) yearOfBirthSentence,
      if (useInterests) interestSentence,
      if (useTherapy) therapySentence,
      if (useCancer) cancerTypeSentence,
      if (useCircumstances) circumstancesSentence,
    ];
    String msg = result.join('. ');
    return [customMessage, msg].join("\n");
  }

  void sendPing(String firstMsg) async {
    // get (random) users/some users
    final userProfileStream = db.userProfilesStream();
    await for (var userProfiles in userProfileStream) {
      for (var otherProfile in userProfiles) {
        if (otherProfile.id == userProfile.id) continue;
        print("profile: $otherProfile ");
        _createChat(userProfile.id, otherProfile.id).then(
          (chatID) {
            db.setMessage(
              chatID,
              Message(
                id: documentIdFromCurrentDate(),
                author: userProfile.id,
                body: firstMsg,
              ),
            );
          },
        );
      }
    }
  }

  static String _chatID(String userID1, String userID2) {
    var ids = [userID1, userID2];
    ids.sort();
    final data = utf8.encode(ids.join(""));
    return sha256.convert(data).toString();
  }

  // ACTIONS
  Future<String> _createChat(String myUserID, String otherUserID) async {
    var chatID = _chatID(myUserID, otherUserID);
    print(chatID);
    final chat = Chat(
      id: chatID,
      participants: [myUserID, otherUserID],
    );
    await db.setChat(chat);
    return chatID;
  }
}
