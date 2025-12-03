import 'package:chat_app/widgets/new_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  //instaed a helper method
  void setupPushNotification() async {
    final fcm = FirebaseMessaging.instance;
    await fcm
        .requestPermission(); //we can get the sata inside but not important
    final token = await fcm.getToken();
    print(token);
    //if i want to send a push notification to all the group in a channel
    fcm.subscribeToTopic('chat');
    // it is in the second section in firebase messaging steps 
  }

  @override
  void initState() {
    super.initState();
    setupPushNotification();
    //it is not recommended adding async await in initstate functions ===> flutter doesnt expect my initstate to return a future
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance
                  .signOut(); //removes the token from device and memory
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: ChatScreen()),
          NewMessages(),
        ],
      ),
    );
  }
}
