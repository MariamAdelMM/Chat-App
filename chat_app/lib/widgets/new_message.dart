import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  const NewMessages({super.key});
  @override
  State<NewMessages> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessages> {
  var _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _submitMsg() {
    final _enteredMessage = _messageController.text;
    if (_enteredMessage.trim().isEmpty) {
      return;
    }
    //send to firebase
    _messageController.clear();
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
