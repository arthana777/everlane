import 'package:everlane/data/models/product_model.dart';
import 'package:flutter/material.dart';

class Questionsetial extends StatelessWidget {
  final Product product;

  const Questionsetial({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name ?? ""),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image ??'', height: 250),
            SizedBox(height: 16),
            Text(product.name ?? '',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Price: ${product.price?.toString() ?? "N/A"}',
                style: TextStyle(fontSize: 20, color: Colors.green)),
            SizedBox(height: 16),
            Text(product.description ?? '',
                style: TextStyle(fontSize: 16)),
            // Add more product details as needed
          ],
        ),
      ),
    );
  }
}
