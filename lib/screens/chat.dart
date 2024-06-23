import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../constants/Theme.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Map<String, dynamic>> messages = [];
  String userid = '7';
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  List<String>? randomQuestions;
  // Define predefined questions
  List<String> predefinedQuestions = [
    "What are the benefits of recycling?",
    "How to start recycling?",
    "Why is recycling important?",
    "What materials can be recycled?",
    "What is the recycling process?",
    "What is composting?",
    "How does recycling save energy?",
    "What are the economic benefits of recycling?",
    "Can all plastics be recycled?",
    "How can I recycle electronics?",
    "What is upcycling?",
    "What is downcycling?",
    "How can schools promote recycling?",
    "What is zero waste?",
    "How can I reduce my plastic use?",
    "What is a circular economy?",
  ];

  // Random number generator
  Random random = Random();

  // Randomly select 2 questions
  List<String> getRandomQuestions() {
    List<String> selectedQuestions = [];
    while (selectedQuestions.length < 2) {
      int index = random.nextInt(predefinedQuestions.length);
      if (!selectedQuestions.contains(predefinedQuestions[index])) {
        selectedQuestions.add(predefinedQuestions[index]);
      }
    }
    return selectedQuestions;
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchMessages();
    _timer = Timer.periodic(Duration(seconds: 10), (Timer t) => _fetchMessages());
   randomQuestions = getRandomQuestions();
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
    final response = await http.get(Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterFetchMessages.php?chat=$userid'));

    if (response.statusCode == 200) {
      setState(() {
        messages = List<Map<String, dynamic>>.from(json.decode(response.body));
        _scrollToBottom();
      });
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> _sendMessage(String message) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.5/ECO/Eco-skydah/Admin Dashboard/FlutterSendMessages.php'),
      body: {
        'message': message,
        'Uid': userid,
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        messages.add({
          'Message': message,
          'SenderID': userid,
        });
        _controller.clear();
        _scrollToBottom();
      });
    } else {
      throw Exception('Failed to send message');
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
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
    // Get 2 random questions
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          // Random Questions Row
          Expanded(
            child: RefreshIndicator(
              onRefresh: _fetchMessages,
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.all(16.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  bool isMe = messages[index]['SenderID'].toString() == userid;

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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                // Display random questions as buttons
                ...randomQuestions!.map((question) => ElevatedButton(
                      onPressed: () {
                        _sendMessage(question);
                      },
                      child: Text(question),
                    )),
              ],
            ),
          ),
          
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
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.send, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
