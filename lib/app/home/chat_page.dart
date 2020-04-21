import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/common_widgets/list_items_builder.dart';
import 'package:trust_ping_app/services/firebase_auth_service.dart';
import 'package:trust_ping_app/services/firestore_database.dart';

import 'models.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({this.chat});
  final Chat chat;

  @override
  Widget build(BuildContext context) {
    String myUserId = Provider.of<User>(context, listen: false).uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.otherParticipant(myUserId)),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildMessageList(context),
        Divider(height: 1.0),
        MessageComposer(conversationID: chat.id),
      ],
    );
  }

  Flexible _buildMessageList(BuildContext context) {
    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final userID = Provider.of<User>(context, listen: false).uid;
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: db.messagesStream(chat.id),
        builder: (context, snapshot) {
          return ListItemsBuilder<Message>(
            snapshot: snapshot,
            itemBuilder: (context, message) {
              return MessageListTile(message: message, userID: userID);
            },
          );
        },
      ),
    );
  }
}

/// A fancy text input field to compose a message
class MessageComposer extends StatefulWidget {
  const MessageComposer({this.conversationID});
  final String conversationID;

  @override
  _State createState() => _State(conversationID: conversationID);
}

class _State extends State<MessageComposer> {
  _State({this.conversationID});
  final String conversationID;

  final TextEditingController _textController = TextEditingController();
  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _textController,
                  onChanged: (String text) {
                    setState(() {
                      _isComposing = text.length > 0;
                    });
                  },
                  // onSubmitted: _handleSubmitted,
                  decoration:
                      InputDecoration.collapsed(hintText: "Send a message"),
                ),
              ),
              Container(
                child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(context, _textController.text)
                      : null,
                ),
                margin: EdgeInsets.symmetric(horizontal: 4),
              )
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
    );
  }

  void _handleSubmitted(BuildContext context, String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });

    final db = Provider.of<FirestoreDatabase>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);

    final message = Message(
      id: documentIdFromCurrentDate(),
      author: user.uid,
      body: text,
    );
    db.setMessage(conversationID, message);
  }
}

class MessageListTile extends StatelessWidget {
  const MessageListTile({this.message, this.userID});
  final Message message;
  final String userID;

  @override
  Widget build(BuildContext context) {
    final alignment =
        (userID == message.author) ? Alignment.topRight : Alignment.topLeft;
    final textAlign =
        (userID == message.author) ? TextAlign.right : TextAlign.left;
    final left = (userID == message.author) ? 48.0 : 0.0;
    final right = (userID == message.author) ? 0.0 : 48.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(left, 0, right, 0),
      child: Card(
        child: Padding(
          child: Align(
            child: Text(message.body, textAlign: textAlign),
            alignment: alignment,
          ),
          padding: const EdgeInsets.all(10.0),
        ),
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
