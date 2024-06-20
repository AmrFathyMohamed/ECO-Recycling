// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../constants/Theme.dart';

//widgets
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, dynamic>> messages = [];
  late String userid;
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchMessages();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) => _fetchMessages());
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userid = prefs.getString('userid') ?? '7';
    });
  }

  Future<void> _fetchMessages() async {
    final response = await http.get(Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterFetchMessages.php?chat=2'));

    if (response.statusCode == 200) {
      setState(() {
        messages = List<Map<String, dynamic>>.from(json.decode(response.body));
        _scrollToBottom();
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final response = await http.post(
        Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterSendMessages.php'),
        body: {
          'message': _controller.text,
          'chat': '2',
          'Uid': userid,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          messages.add({
            'Message': _controller.text,
            'SenderID': userid,
          });
          _controller.clear();
          _scrollToBottom();
        });
      } else {
        throw Exception('Failed to send message');
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

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
                child: RefreshIndicator(
                  onRefresh: _fetchMessages,
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.0),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      bool isMe = messages[index]['SenderID'] == userid;
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5.0),
                          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.green[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Text(
                            messages[index]['Message'],
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),
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
}
