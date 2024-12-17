import 'package:flutter/material.dart';

import 'form_detail.dart';
import 'form_input.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<StatefulWidget> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.shopping_bag),
        title: const Text('PRODUCT DATA'),
        centerTitle: true,
        actions: [
          GestureDetector(
            child: const Icon(
              Icons.add_box,
              size: 50,
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormInput()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10.0), // Add padding to ListView
        children: [
          ItemProduk(
            productName: 'Laptop',
            category: 'Electronics',
            price: '1200',
            availability: 'In Stock',
          ),
          ItemProduk(
            productName: 'Smartphone',
            category: 'Electronics',
            price: '800',
            availability: 'Out of Stock',
          ),
          ItemProduk(
            productName: 'Desk Chair',
            category: 'Furniture',
            price: '150',
            availability: 'In Stock',
          ),
        ],
      ),
    );
  }
}

class ItemProduk extends StatelessWidget {
  final String? productName;
  final String? category;
  final String? price;
  final String? availability;

  const ItemProduk({
    Key? key,
    this.productName,
    this.category,
    this.price,
    this.availability,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30),
        elevation: 3.0, // Adds shadow effect to the card
        child: ListTile(
          title: Text(productName ?? 'No Product Name'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Category: ${category ?? 'Not Specified'}'),
              Text('Price: \$${price ?? '0'}'),
              Text('Availability: ${availability ?? 'Unknown'}'),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FormDetail(
              productName: productName,
              category: category,
              price: price,
              availability: availability,
            ),
          ),
        );
      },
    );
  }
}