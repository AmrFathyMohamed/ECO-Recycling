// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../constants/Theme.dart';

//widgets
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';
import '../widgets/input.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages = [];
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Navbar(
        title: "Chat",
        searchBar: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: ArgonDrawer(currentPage: "Chat"),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                      image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Chat Messages
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(16.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: index % 2 == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? ArgonColors.primary.withOpacity(0.8)
                              : ArgonColors.primaryGr.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Text(
                          messages[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Input Field
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    FloatingActionButton(
                      onPressed: _sendMessage,
                      backgroundColor: ArgonColors.primary,
                      child: Icon(Icons.send, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text);
        _controller.clear();
      });
    }
  }
}
