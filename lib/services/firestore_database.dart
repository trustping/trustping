import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:trust_ping_app/app/home/models.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

/// Encode the paths of firestore documents.
class _Path {
  static String job(String userID, String jobId) => 'users/$userID/jobs/$jobId';
  static String jobs(String userID) => 'users/$userID/jobs';
  static String entry(String userID, String entryId) =>
      'users/$userID/entries/$entryId';
  static String entries(String userID) => 'users/$userID/entries';

  static String chats() => 'chats';
  static String conversation(String conversationID) => 'chats/$conversationID';
  static String messages(String conversationID) =>
      'chats/$conversationID/messages';
  static String message(String conversationID, String messageID) =>
      'chats/$conversationID/messages/$messageID';
}

/// The main interface to entities that live in the firebase database.
/// Note that you get fully typed domain entities, not snapshots.
class FirestoreDatabase {
  FirestoreDatabase({@required this.userID}) : assert(userID != null);
  final String userID; // user id
  final _service = FirestoreService.instance;

  // chats
  Stream<List<Chat>> chatsStream() => _service.collectionStream(
        path: _Path.chats(),
        builder: (data, documentId) => Chat.fromMap(data, documentId),
      );

  Future<void> setChat(Chat conversation) async => await _service.setData(
        path: _Path.conversation(conversation.id),
        data: conversation.toMap(),
      );

  // MESSAGES
  Stream<List<Message>> messagesStream(String conversationID) {
    return _service.collectionStream(
      path: _Path.messages(conversationID),
      builder: (data, documentID) => Message.fromMap(data, documentID),
    );
  }

  Future<void> setMessage(String conversationID, Message message) async {
    return await _service.setData(
      path: _Path.message(conversationID, message.id),
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
