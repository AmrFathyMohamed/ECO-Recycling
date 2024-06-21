import 'dart:convert';

import 'package:http/http.dart' as http;

class Product {
  final String name;
  final double price;
  int quantity;
  final String image;

  String description;

  Product({
    required this.name,
    required this.price,
    this.quantity = 0,
    required this.image, required this.description,
  });
}
Future<List<Product>> fetchProducts() async {
  String url = 'http://192.168.1.11/ECO/Eco-skydah/Admin Dashboard/FlutterProducts.php'; // Replace with your backend URL
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List<Product> products = (jsonDecode(response.body) as List)
          .map((item) => Product(
                name: item['ProductName'],
                price: double.parse(item['Price']),
                image: "http://192.168.1.11/ECO/Eco-skydah/Admin Dashboard/" + item['Product_image'],
                description: item['Description'],
              ))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
List<Product> getProducts() {
  // Simulate a delay for fetching products (optional for demonstration)
 Future.delayed(const Duration(seconds: 2));

  List<Product> products = [
    Product(
    name: 'Metal',
    price: 25,
    image: 'assets/metal.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Mixed',
    price: 30,
    image: 'assets/mixed.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Organic',
    price: 20,
    image: 'assets/organic.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Paper',
    price: 35,
    image: 'assets/paper.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Plastic',
    price: 25,
    image: 'assets/plastic.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Pulps',
    price: 50,
    image: 'assets/pulps.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Batteries',
    price: 30,
    image: 'assets/batteries.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'E Waste',
    price: 45,
    image: 'assets/E-waste.png',
    description: 'Item to recy'
  ),
  Product(
    name: 'Glass',
    price: 15,
    image: 'assets/glass.png',
    description: 'Item to recy'
  )
    // Add more products as needed
  ];

  // Optional: Perform additional operations on the list if needed
  // Example: Sort the products by price:
  products.sort((a, b) => a.price.compareTo(b.price));

  return products;
}
