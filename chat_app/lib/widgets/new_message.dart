import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});
  @override
  State<NewMessages> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessages> {
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMsg() async {
    final _enteredMessage = _messageController.text;
    if (_enteredMessage.trim().isEmpty) {
      return;
    }

    ///to close the keyboard
    FocusScope.of(context).unfocus();
    //send to firebase
    _messageController.clear();
    final user = FirebaseAuth.instance.currentUser!;
    //we retrieve it from firestore we already sent these data
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'created': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              decoration: InputDecoration(labelText: 'send a  message'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,

            onPressed: _submitMsg,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
