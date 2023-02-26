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
  var fieldE = TextEditingController();

  getMessage() async {
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
      backgroundColor: Colors.black,
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
                // getMessage();
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(getMessage().toString()),
              StreamBuilder<QuerySnapshot<Object>>(
                stream: FirebaseFirestore.instance
                    .collection('messages')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    final message = snapshot.data.docs;
                    List<Widget> messagelist = [];

                    //print(messages);
                    bool isequal;
                    for (var messages in message) {
                      print(messages);
                      final txtmessage = messages['text'];
                      final sendermail = messages['sender'];
                      if (FirebaseAuth.instance.currentUser == sendermail) {
                        isequal = true;
                      } else {
                        isequal = false;
                      }
                      final mwidget = Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              sendermail,
                              style:
                                  TextStyle(fontSize: 10, color: Colors.white),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isequal == true
                                    ? Colors.green
                                    : Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                txtmessage,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Divider(
                              color: Colors.white,
                              thickness: 0.2,
                            )
                          ],
                        ),
                      );
                      // print('$txtmessage from $sendermail');
                      messagelist.add(mwidget);
                      
                    }

                    return Expanded(
                      child: ListView(
                        padding: EdgeInsets.all(0),
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
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 0.0),
                        child: TextFormField(
                          controller: fieldE,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            hintText: 'Type message here...',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          onChanged: (value) {
                            message = value;
                          },
                        ),
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
                            fieldE.clear();
                          },
                          child: const Text('Send',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
