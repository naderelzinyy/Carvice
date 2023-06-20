import 'package:carvice_frontend/services/authentication.dart';
import 'package:carvice_frontend/utils/main.colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/chat_style_utils.dart';

class ChattingScreen extends StatefulWidget {
  final String selectedFriendUserName;
  final String? autoMessage;
  const ChattingScreen({
    super.key,
    required this.selectedFriendUserName,
    this.autoMessage,
  });

  @override
  ChattingScreenState createState() => ChattingScreenState();
}

class ChattingScreenState extends State<ChattingScreen> {
  final _fireBaseAuth = FirebaseAuth.instance;
  final _fireStoreAuth = FirebaseFirestore.instance;
  final textFieldController = TextEditingController();
  late String textMessage;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void createConversation(String friendUserName) async {
    if (token != null) {
      final messageToSend = widget.autoMessage ?? textMessage;

      // create conversation for current user
      final userDoc = await _fireStoreAuth
          .collection('users')
          .doc(token!['id'].toString())
          .get();
      if (userDoc.exists) {
        final conversation =
            userDoc.reference.collection('conversations').doc(friendUserName);
        conversation.set({
          "friend_username": friendUserName,
          "timestamp": Timestamp.now(),
        });
        conversation.collection('messages').add({
          "message": messageToSend,
          "msg_date": Timestamp.now(),
          "sender": token!['username'],
        });
      } else {
        print('User document does not exist');
      }
      // create conversation for friend user
      final friendDoc = await _fireStoreAuth
          .collection('users')
          .where('username', isEqualTo: friendUserName)
          .get();
      if (friendDoc.docs.isNotEmpty) {
        final friendConversation = friendDoc.docs.first.reference
            .collection('conversations')
            .doc(token!['username']);
        friendConversation.set({
          "friend_username": token!['username'],
          "timestamp": Timestamp.now(),
        });
        friendConversation.collection('messages').add({
          "message": messageToSend,
          "msg_date": Timestamp.now(),
          "sender": token!['username'],
        });
      } else {
        print('Friend document does not exist');
      }
    }
  }

  void getUser() async {
    try {
      // TODO : CURR USER TO BE LINKED WITH sql database
      token;
      final currUser = _fireBaseAuth.currentUser;
      if (currUser != null) {
        token!['username'] = currUser;
        print(currUser);
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                Get.offAllNamed(Routers.getClientChatListRoute());
              }),
        ],
        title: Text(
          widget.selectedFriendUserName,
          style: const TextStyle(fontSize: 24),
        ),
        backgroundColor: MainColors.mainColor,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StreamMessagesBuilder(
                fireStoreAuth: _fireStoreAuth,
                friendUserName: widget.selectedFriendUserName),
            Container(
              decoration: myMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: textFieldController,
                      onChanged: (text) {
                        textMessage = text;
                      },
                      decoration: myMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      textFieldController.clear();
                      createConversation(widget.selectedFriendUserName);
                    },
                    child: const Text(
                      'Send',
                      style: mySendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamMessagesBuilder extends StatelessWidget {
  final FirebaseFirestore fireStoreAuth;
  final String friendUserName;

  const StreamMessagesBuilder({
    required this.fireStoreAuth,
    required this.friendUserName,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStoreAuth
            .collection('users')
            .doc(token!['id'].toString())
            .collection('conversations')
            .where("friend_username", isEqualTo: friendUserName)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final conversations = snapshot.data!.docs.reversed;
          if (conversations.isEmpty) {
            return const Text(
              "Sey hello ♡",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w100),
              textAlign: TextAlign.center,
            );
          }
          final conversation = conversations.first;
          return StreamBuilder<QuerySnapshot>(
              stream: conversation.reference
                  .collection('messages')
                  .orderBy('msg_date')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!.docs.reversed;
                List<BubbleTextBuilder> bubblesChatList = [];
                for (var message in messages) {
                  final messageData = message;
                  final messageBubble = BubbleTextBuilder(
                    message: messageData['message'],
                    username: messageData['sender'],
                    isSelfSender: token!["username"] == messageData['sender'],
                  );
                  bubblesChatList.add(messageBubble);
                }
                return Expanded(
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    children: bubblesChatList,
                  ),
                );
              });
        });
  }
}

class BubbleTextBuilder extends StatelessWidget {
  final String username;
  final bool isSelfSender;
  final String message;
  const BubbleTextBuilder(
      {required this.message,
      required this.username,
      required this.isSelfSender});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              isSelfSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: const TextStyle(fontSize: 16, color: Colors.black45),
            ),
            Material(
              elevation: 6.0,
              borderRadius: isSelfSender
                  ? myBubbleMessageRadiusDecoration.copyWith(
                      topLeft: const Radius.circular(30))
                  : myBubbleMessageRadiusDecoration.copyWith(
                      topRight: const Radius.circular(30)),
              color: isSelfSender ? MainColors.mainColor : Colors.white,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatService {
  final _fireStoreAuth = FirebaseFirestore.instance;

  void createConversation(String friendUserName, String message,
      {String autoMessage = ""}) async {
    if (token != null) {
      // create conversation for current user
      final userDoc = await _fireStoreAuth
          .collection('users')
          .doc(token!['id'].toString())
          .get();
      if (userDoc.exists) {
        final conversation =
            userDoc.reference.collection('conversations').doc(friendUserName);
        conversation.set({
          "friend_username": friendUserName,
          "timestamp": Timestamp.now(),
        });
        conversation.collection('messages').add({
          "message": autoMessage.isEmpty ? message : autoMessage,
          "msg_date": Timestamp.now(),
          "sender": token!['username'],
        });
      } else {
        print('User document does not exist');
      }
      // create conversation for friend user
      final friendDoc = await _fireStoreAuth
          .collection('users')
          .where('username', isEqualTo: friendUserName)
          .get();
      if (friendDoc.docs.isNotEmpty) {
        final friendConversation = friendDoc.docs.first.reference
            .collection('conversations')
            .doc(token!['username']);
        friendConversation.set({
          "friend_username": token!['username'],
          "timestamp": Timestamp.now(),
        });
        friendConversation.collection('messages').add({
          "message": autoMessage.isEmpty ? message : autoMessage,
          "msg_date": Timestamp.now(),
          "sender": token!['username'],
        });
      } else {
        print('Friend document does not exist');
      }
    }
  }
}
