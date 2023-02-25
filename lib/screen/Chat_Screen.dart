import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final Currentuser = FirebaseAuth.instance.currentUser;
  late String message;
  //late String currenU;

  Future<void> getMessage() async {
    await for (var snapshot
        in FirebaseFirestore.instance.collection('messages').snapshots()) {
      for (var snapshot in snapshot.docs) {
        print(snapshot.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 20,
            ),
            const Text(
              'Chat',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () async {
                //             await for (var snapshot
                //     in FirebaseFirestore.instance.collection('messages').snapshots()) {
                //   for (var snapshot in snapshot.docs) {
                //     print(snapshot.data());
                //   }
                // }
                // print(getMessage().toString());
                // await for (var snapshot in FirebaseFirestore.instance
                //     .collection('messages')
                //     .snapshots()) {
                //   for (var snaphott in snapshot.docs) {
                //     print(snaphott.data());
                //   }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<QuerySnapshot<Object>>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final messages = snapshot.data.document;
                    List<Text> messagelist = [];

                    for (var message in messages) {
                      final txtmessage = message.data['text'];
                      final sendermail = message.data['sender'];
                      final mwidget = Text('$txtmessage from $sendermail');
                      print('$txtmessage from $sendermail');
                      messagelist.add(mwidget);
                    }

                    return Expanded(
                      child: Column(
                        children: messagelist,
                      ),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Not connected to the stream');
                    case ConnectionState.waiting:
                      return Text('Waiting for data...');
                    case ConnectionState.active:
                      return Text('Got data: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream closed');
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      decoration: const InputDecoration(
                        fillColor: Colors.white38,
                        border: InputBorder.none,
                        hintText: 'Type message here...',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      onChanged: (value) {
                        message = value;
                      },
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          FirebaseFirestore.instance
                              .collection('messages')
                              .add({
                            'text': message,
                            'sender': FirebaseAuth.instance.currentUser!.email
                                .toString()
                          });
                        },
                        child: const Text('Send',
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
