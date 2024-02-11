import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/chat_model.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  MarketModel? receiverUser;
  final TextEditingController messageController = TextEditingController();
  getConversationId(String receiverId) =>
      FirebaseAuth.instance.currentUser!.uid.hashCode <= receiverId.hashCode
          ? '${FirebaseAuth.instance.currentUser!.uid}_$receiverId'
          : '${receiverId}_${FirebaseAuth.instance.currentUser!.uid}';
  @override
  Widget build(BuildContext context) {
    // var provider = Provider.of<ChatProvider>(context, listen: false);
    return Scaffold(
      body: Row(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sellers')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No Data Found'),
                        );
                      }

                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            MarketModel marketModel = MarketModel.fromMap(
                                snapshot.data!.docs[index].data());
                            return InkWell(
                              onTap: () {
                                receiverUser = marketModel;
                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              marketModel.imageUrl),
                                        ),
                                        Text(marketModel.marketName),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    // Text('Message'),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })),
          if (receiverUser != null)
            Expanded(
                child: Column(
              children: [
                Container(
                  height: 80,
                  color: primaryColor,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(receiverUser!.imageUrl),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          Text(receiverUser!.marketName),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(getConversationId(receiverUser!.uid))
                          .collection('messages')
                          .orderBy('time', descending: false)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.isEmpty) {
                            return const Center(
                              child: Text('No Data Found'),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                ChatModel chat = ChatModel.fromMap(
                                    snapshot.data!.docs[index].data());
                                bool isMe = chat.senderId ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? true
                                    : false;
                                return MessageBubble(
                                    sender: chat.name,
                                    text: chat.message,
                                    isMe: isMe);
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      }),
                ),
                TextFormField(
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    suffixIcon: IconButton(
                        onPressed: () {
                          String randomId = const Uuid().v4();

                          ChatModel chatModel = ChatModel(
                              id: randomId,
                              name: 'Admin',
                              message: messageController.text,
                              time: DateTime.now(),
                              avatarUrl: '',
                              senderId: FirebaseAuth.instance.currentUser!.uid,
                              receiverId: receiverUser!.uid);

                          FirebaseFirestore.instance
                              .collection('chats')
                              .doc(getConversationId(receiverUser!.uid))
                              .collection('messages')
                              .doc(randomId)
                              .set(chatModel.toMap());
                          messageController.clear();
                        },
                        icon: const Icon(Icons.send)),
                  ),
                )
              ],
            )),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  const MessageBubble(
      {super.key,
      required this.sender,
      required this.text,
      required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(sender),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              margin: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: isMe ? primaryColor : Colors.grey[300],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                text,
                style: TextStyle(color: isMe ? Colors.white : Colors.black),
              ),
            ),
          ],
        ));
  }
}
