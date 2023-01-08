import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  final String username;

  ChatScreen({required this.username});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _firestore =
      FirebaseFirestore.instance; // Create an instance of Firestore
  final _textController =
      TextEditingController(); // Declare a TextEditingController
  final _listViewController = ScrollController();
  late String
      _currentChatroom; // Declare a variable to store the current chatroom

  @override
  void initState() {
    super.initState();
    // Set the current chatroom to the General Chat chatroom when the screen loads
    _currentChatroom = 'General Chat';
  }


  void _sendMessage() {
    // Get the message from the text field
    final message = _textController.text;
    // Clear the text field
    _textController.clear();
    // Create a Timestamp object for the current time
    final messageTimestamp = Timestamp.fromMillisecondsSinceEpoch(
        DateTime.now().millisecondsSinceEpoch);
    // Add the message to the chatroom collection in the database
    _firestore.collection(_currentChatroom).add({
      'sender': widget.username,
      'message': message,
      'timestamp': messageTimestamp,
    })
      ..then((value) {
        // Scroll to the bottom of the ListView
        _listViewController
            .jumpTo(_listViewController.position.maxScrollExtent);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
// Display the name of the current chatroom in the AppBar
        title: Text(_currentChatroom),
// Add a button to the AppBar that allows users to change chatrooms
        actions: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Chat Rooms',
                style: TextStyle(
                  fontSize: 18,
                ),),
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.sliders,
                ),
                onPressed: () async {
                  String selectedChatroom = await showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: Text('Select a chatroom'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'General Chat');
                            },
                            child: Row(
                              children: [
                                Icon(Icons.chat),
                                SizedBox(width: 10),
                                Text('General Chat'),
                              ],
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Football');
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.futbol),
                                SizedBox(width: 10),
                                Text('Football'),
                              ],
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Fitness');
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.dumbbell),
                                SizedBox(width: 10),
                                Text('Fitness'),
                              ],
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Relationship');
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.heart),
                                SizedBox(width: 10),
                                Text('Relationship'),
                              ],
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Relationship');
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.planeDeparture),
                                SizedBox(width: 10),
                                Text('Relationship'),
                              ],
                            ),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Coding Club');
                            },
                            child: Row(
                              children: [
                                Icon(FontAwesomeIcons.code),
                                SizedBox(width: 10),
                                Text('Coding Club'),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                  setState(() {
                    _currentChatroom = selectedChatroom;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // Display the messages in the chatroom using a StreamBuilder
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(_currentChatroom)
                  .orderBy(
                    'timestamp',
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data?.docs;
                List<MessageBubble> messageBubbles = [];
                for (var message in messages!) {
                  final messageText = message['message'];
                  final messageSender = message['sender'];
                  final messageTimestamp = message['timestamp'];
                  final currentUser = widget.username;

                  final messageBubble = MessageBubble(
                    sender: messageSender,
                    text: messageText,
                    timestamp: messageTimestamp as Timestamp,
                    isMe: currentUser == messageSender,
                  );

                  messageBubbles.add(messageBubble);
                }
                return ListView(
                  reverse: false,
                  controller: _listViewController,
                  children: messageBubbles,
                );
              },
            ),
          ),
          Container(
            // decoration: BoxDecoration(
            //   border: Border(
            //     top: BorderSide(color: Colors.grey, width: 2.0),
            //   ),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 80,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Center(
                        child: TextField(
                          controller: _textController,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(20.0),
                            hintText: 'Enter a message...',
                            hintStyle: TextStyle(color: Colors.black),
                            labelStyle: TextStyle(color: Colors.white),
                            border: InputBorder.none,
                          ),
                          minLines: 1,
                          maxLines: 10, // allow for up to 5 lines
                        ),
                      ),
                    )
                  ),
                  SizedBox(width: 1,),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      color: Colors.green.shade500,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.send),
                      onPressed: () => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble(
      {required this.sender,
      required this.text,
      required this.timestamp,
      required this.isMe});

  final String sender;
  final String text;
  final Timestamp timestamp;
  final bool isMe;

  String get elapsedTime {
    final now = DateTime.now();
    final messageTime = timestamp.toDate();
    final elapsed = now.difference(messageTime);
    if (elapsed.inMinutes < 1) {
      return 'Just now';
    } else if (elapsed.inMinutes == 1) {
      return '1 minute ago';
    } else if (elapsed.inHours < 1) {
      return '${elapsed.inMinutes} minutes ago';
    } else if (elapsed.inHours == 1) {
      return '1 hour ago';
    } else if (elapsed.inDays < 1) {
      return '${elapsed.inHours} hours ago';
    } else if (elapsed.inDays == 1) {
      return '1 day ago';
    } else {
      return '${elapsed.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
        isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 5,),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                topRight: Radius.circular(30.0),
                topLeft: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0)
              ),
            elevation: 5.0,
            color: isMe ? Colors.green : Colors.orange,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: '$text',
                  style: TextStyle(color: isMe ? Colors.white : Colors.black54, fontSize: 15.0,),
                  children: <TextSpan>[
                    TextSpan(
                      text: '  ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                    TextSpan(
                      text: '$elapsedTime,',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              ),
              // child: Text(
              //   '$text',
              //   style: TextStyle(
              //     color: isMe ? Colors.white : Colors.black54,
              //     fontSize: 15.0,
              //   ),
              // ),
            ),
        ],
      ),
    );
  }
}