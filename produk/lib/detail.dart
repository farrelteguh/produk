import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:produk/models/model_produk.dart';
import 'edit.dart';

class Detail extends StatefulWidget {
  final ProdukModel product;
  Detail({required this.product});

  @override
  State<StatefulWidget> createState() => DetailState();
}

class DetailState extends State<Detail> {
  void deleteProduct(context) async {
    http.Response response = await http.post(
      Uri.parse('http://127.0.0.1/produkk/delete.php'),
      body: {'id': widget.product.id.toString()},
    );
    final data = json.decode(response.body);
    if (data['success']) {
      showToast();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  showToast() {
    Fluttertoast.showToast(
      msg: "Product successfully deleted",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () => deleteProduct(context),
              child: Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Removed the photoUrl conditional block here
            ListTile(
              leading: Icon(Icons.perm_identity, size: 28, color: Colors.blue),
              title: Text('ID: ${widget.product.id}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_cart, size: 28, color: Colors.blue),
              title: Text('Product Name: ${widget.product.product_name}', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.category, size: 28, color: Colors.blue),
              title: Text('Category: ${widget.product.category}', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.money_rounded, size: 28, color: Colors.blue),
              title: Text('Price: \Rp.${widget.product.price}', style: TextStyle(fontSize: 18)),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description, size: 28, color: Colors.blue),
              title: Text('Description: ${widget.product.description}', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        hoverColor: Colors.green,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => Edit(product: widget.product)),
        ),
        child: Icon(Icons.edit, color: Colors.white),
      ),
    );
  }
}