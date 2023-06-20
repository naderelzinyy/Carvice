import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../../services/authentication.dart';
import '../../../../utils/main.colors.dart';
import 'chatting_page.dart';

class ChatHomePage extends StatefulWidget {
  static const route = "/chat_list_page";
  const ChatHomePage({super.key});

  void startChat(BuildContext context, String username) {
    // Chat Request method, starts a conversation immediately given the username
    print("startChat starts...");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChattingScreen(selectedFriendUserName: username),
      ),
    );
  }

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(token!['id'].toString())
              .collection('conversations')
              .where('friend_username', isNotEqualTo: token!['username'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChattingScreen(
                            selectedFriendUserName: user['friend_username']),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Wrap(
                        children: <Widget>[
                          const SizedBox(
                            width: 8,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: MainColors.mainColor,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/images/person.jpeg",
                                width: 74,
                                height: 74,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            user!["friend_username"],
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 26),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
