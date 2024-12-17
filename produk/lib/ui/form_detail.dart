import 'package:flutter/material.dart';

class FormDetail extends StatefulWidget {
  @override
  final String? productName;
  final String? category;
  final String? price;
  final String? description;
  final String? availability;

  const FormDetail({
    Key? key,
    this.productName,
    this.category,
    this.price,
    this.description,
    this.availability,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => FormDetailState();
}

class FormDetailState extends State<FormDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
      body: Align(
        alignment: Alignment.topCenter, // Places content at the top center
        child: Card(
          elevation: 5.0, // Adds shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0), // Rounded corners
          ),
          margin: const EdgeInsets.only(top: 20.0), // Top margin
          child: Padding(
            padding: const EdgeInsets.all(50.0), // Padding inside the card
            child: Column(
              mainAxisSize: MainAxisSize.min, // Takes minimum required space
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Product Name: ${widget.productName ?? 'N/A'}",
                  style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0), // Space between texts
                Text(
                  "Category: ${widget.category ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Price: ${widget.price ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Description: ${widget.description ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16.0),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Availability: ${widget.availability ?? 'N/A'}",
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}