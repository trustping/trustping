import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trust_ping_app/common_widgets/list_items_builder.dart';
import 'package:trust_ping_app/services/firestore_database.dart';
import 'package:trust_ping_app/theme.dart';

import 'models/chat.dart';
import 'models/message.dart';
import 'models/user.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;
  const ChatPage({this.chat});

  @override
  Widget build(BuildContext context) {
    String myUserID = Provider.of<User>(context, listen: false).uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(chat.otherParticipant(myUserID)),
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
  final String conversationID;
  const MessageComposer({this.conversationID});

  @override
  _State createState() => _State(conversationID: conversationID);
}

class _State extends State<MessageComposer> {
  final String conversationID;
  final TextEditingController _textController = TextEditingController();

  bool _isComposing = false;
  _State({this.conversationID});

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
  final Message message;
  final String userID;
  const MessageListTile({this.message, this.userID});

  @override
  Widget build(BuildContext context) {
    final bool myMessage = userID == message.author;
    final alignment = myMessage ? Alignment.topRight : Alignment.topLeft;
    final textAlign = myMessage ? TextAlign.right : TextAlign.left;
    final left = myMessage ? 80.0 : 0.0;
    final right = myMessage ? 0.0 : 80.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(left, 8, right, 0),
      child: Card(
        color: myMessage ? Style.red : Style.yellow,
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
