import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true) //the latest at the bottom
          .snapshots(),
      builder: (context, chatSnapShots) {
        if (chatSnapShots.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!chatSnapShots.hasData || chatSnapShots.data!.docs.isEmpty) {
          return const Center(child: Text('No Messages found...'));
        }
        if (chatSnapShots.hasError) {
          return const Center(child: Text('Something went wrong...'));
        }
        final loadedMessages = chatSnapShots.data!.docs;
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 40, left: 13, right: 13),
          reverse: true, //from bottom to top
          itemCount: loadedMessages.length,
          itemBuilder: (ctx, index) =>
              Text(loadedMessages[index].data()['text']),
        );
      },
    ); //will setup a listener to listen to remote database whenever a new message sent it reads it and trigger this builder and update ui, builder: builder)
  }
}
