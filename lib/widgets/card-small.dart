import 'package:flutter/material.dart';

class CardSmall extends StatelessWidget {
  final String cta;
  final String title;
  final String img;
  final VoidCallback tap;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CardSmall({super.key, 
    required this.cta,
    required this.title,
    required this.img,
    required this.tap,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
Widget build(BuildContext context) {
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          height: 150, // Adjust height as per your design
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(img), // Assuming 'img' is a String URL
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: onDecrement,
            ),
            Text('$quantity'),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: onIncrement,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: tap,
          child: Text(cta),
        ),
      ],
    ),
  );
}
}