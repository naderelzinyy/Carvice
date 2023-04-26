import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chatting_page.dart';

class ChatHomePage extends StatefulWidget {
  static const route = "chat_list_page";
  const ChatHomePage({super.key});

  @override
  _ChatHomePageState createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white54,
        flexibleSpace: const FlexibleSpaceBar(
          title: Text(
            'Chats',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _fireStore.collection('users').snapshots(),
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
                        builder: (context) =>
                            ChattingScreen(selectedFriendEmail: user['email']),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: <Widget>[
                          const SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/person.jpeg",
                            width: 56,
                            height: 56,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            user['email'],
                            textDirection: TextDirection.rtl,
                            style: const TextStyle(fontSize: 22),
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
