import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/Theme.dart';
import '../widgets/navbar.dart';
import '../widgets/drawer.dart';

class Rewards extends StatefulWidget {
  const Rewards({super.key});

  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  int totalPoints = 0;
  List<Transaction> transactions = [];
  String userId = '';

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('userid') ?? '';
    });
    if (userId.isNotEmpty) {
      _fetchUserData(userId);
    }
  }

  Future<void> _fetchUserData(String userId) async {
    String url = 'http://192.168.1.11/ECO/Eco-skydah/Admin%20Dashboard/FlutterRewards.php';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'userid': userId,
        },
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['status'] == 'success') {
          List<dynamic> userData = data['UserData'];
          setState(() {
            totalPoints = userData.fold(0, (sum, item) => sum + (item['PointsRedeemed'] as int));
            transactions = userData.map((item) => Transaction(points: (item['PointsRedeemed'] as int), date: item['RedemptionDate'])).toList();
          });
        } else {
          // Handle error
          print(data['message']);
        }
      } else {
        // Handle error
        print('Failed to connect to server');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const Navbar(
        title: "Rewards",
        transparent: false,
      ),
      backgroundColor: ArgonColors.bgColorScreen,
      drawer: const ArgonDrawer(currentPage: "Rewards"),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                alignment: Alignment.topCenter,
                image: AssetImage("assets/img/recycling-garbage2.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Stack(
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Card(
                              semanticContainer: true,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              elevation: 0.0,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                                child: Column(
                                  children: [
                                    _buildPointsCircle(totalPoints),
                                    const SizedBox(height: 20.0),
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 16.0),
                                        child: Text(
                                          "Recent Transactions",
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10.0),
                                    _buildTransactionsList(transactions),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointsCircle(int points) {
    return Container(
      width: double.infinity,
      height: 150,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: ArgonColors.primary,
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Total Points',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            points.toString(),
            style: const TextStyle(
              color: Colors.amber,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList(List<Transaction> transactions) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return _buildTransactionItem(transactions[index]);
      },
    );
  }

  Widget _buildTransactionItem(Transaction transaction) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: const Icon(
          Icons.star,
          color: Colors.amber,
          size: 32,
        ),
        title: Text(
          '${transaction.points} Points',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amber,
          ),
        ),
        subtitle: Text(
          'Date: ${transaction.date}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }
}

class Transaction {
  final int points;
  final String date;

  Transaction({required this.points, required this.date});
}