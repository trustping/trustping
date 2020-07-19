import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:trust_ping_app/app/home/models/chat.dart';
import 'package:trust_ping_app/app/home/models/message.dart';
import 'package:trust_ping_app/app/home/models/user_profile.dart';
import 'package:trust_ping_app/app/home/models/user_profile_v2.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/// Encode the paths of firestore documents.
class _Path {
  static String chats() => 'chats';
  static String chat(String chatID) => 'chats/$chatID';

  static String messages(String chatID) => 'chats/$chatID/messages';
  static String message(String chatID, String messageID) =>
      'chats/$chatID/messages/$messageID';

  static String userProfile(String userID) => 'user_profile/$userID';
  static String userProfiles() => 'user_profile/';

  static String userProfileV2(String userID) => 'user_profile_v2/$userID';
  static String userProfilesV2() => 'user_profile_v2/';
}

/// The main interface to entities that live in the firebase database.
/// Note that you get fully typed domain entities, not snapshots.
class FirestoreDatabase {
  FirestoreDatabase({@required this.userID}) : assert(userID != null);
  final String userID;
  final _service = FirestoreService.instance;

  // USER PROFILE
  Future<void> setUserProfile(UserProfile userProfile) async =>
      await _service.setData(
        path: _Path.userProfile(userProfile.id),
        data: userProfile.toMap(),
      );

  Stream<UserProfile> userProfileStream() => _service.documentStream(
        path: _Path.userProfile(userID),
        builder: (data, documentId) => UserProfile.fromMap(data, documentId),
      );

  Stream<List<UserProfile>> userProfilesStream() {
    return _service.collectionStream(
      path: _Path.userProfiles(),
      builder: (data, documentID) => UserProfile.fromMap(data, documentID),
    );
  }

  // USER PROFILE V2
  Future<void> setUserProfileV2(UserProfileV2 userProfile) async =>
      await _service.setData(
        path: _Path.userProfileV2(userProfile.id),
        data: userProfile.toMap(),
      );

  Stream<UserProfileV2> userProfileV2Stream() => _service.documentStream(
        path: _Path.userProfileV2(userID),
        builder: (data, documentId) => UserProfileV2.fromMap(data, documentId),
      );

  Stream<List<UserProfileV2>> userProfilesV2Stream() {
    return _service.collectionStream(
      path: _Path.userProfilesV2(),
      builder: (data, documentID) => UserProfileV2.fromMap(data, documentID),
    );
  }

  // CHATS
  Stream<List<Chat>> chatsStream() => _service.collectionStream(
        path: _Path.chats(),
        builder: (data, documentId) => Chat.fromMap(data, documentId),
      );

  Future<void> setChat(Chat chat) async => await _service.setData(
        path: _Path.chat(chat.id),
        data: chat.toMap(),
      );

  // MESSAGES
  Stream<List<Message>> messagesStream(String chatID) {
    return _service.collectionStream(
      path: _Path.messages(chatID),
      builder: (data, documentID) => Message.fromMap(data, documentID),
    );
  }

  Future<void> setMessage(String chatID, Message message) async {
    return await _service.setData(
      path: _Path.message(chatID, message.id),
      data: message.toMap(),
    );
  }
}

/// Low-level helper to access the firstore instance
class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    @required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = Firestore.instance.document(path);
    print('$path: $data');
    print(data);
    await reference.setData(data, merge: merge);
  }

  Future<void> deleteData({@required String path}) async {
    final reference = Firestore.instance.document(path);
    print('delete: $path');
    await reference.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = Firestore.instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.documents
          .map((snapshot) => builder(snapshot.data, snapshot.documentID))
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  Stream<T> documentStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final DocumentReference reference = Firestore.instance.document(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => builder(snapshot.data, snapshot.documentID));
  }
}
