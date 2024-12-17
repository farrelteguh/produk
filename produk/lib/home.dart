import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:produk/tambah.dart';
import 'package:produk/models/model_produk.dart'; // Ubah sesuai dengan model produk Anda
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';

import 'detail.dart';

class Home extends StatefulWidget {
  @override
  Home({Key? key}) : super(key: key);
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  late Future<List<ProdukModel>> produkList; // Ubah dari SiswaModel ke ProdukModel

  @override
  void initState() {
    super.initState();
    produkList = getProdukList();
  }

  // Ubah URL API sesuai dengan endpoint produk
  Future<List<ProdukModel>> getProdukList() async {
    final response = await http.get(Uri.parse("http://127.0.0.1/produkk/list.php")); // Ganti dengan endpoint produk
    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ProdukModel> produk = items.map<ProdukModel>((json) {
      return ProdukModel.fromJson(json);
    }).toList();
    return produk;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Daftar Produk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
            fontFamily: 'Roboto', // Custom font for a modern look
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 10.0, // Adds a more prominent shadow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.blueAccent], // Gradient background
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)), // Rounded bottom corners
        ),
      ),
      body: Container(
        color: Colors.grey[100], // Light background color for the whole screen
        child: FutureBuilder<List<ProdukModel>>(
          future: produkList,
          builder: (BuildContext context, AsyncSnapshot<List<ProdukModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red))); // Show error message
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data found', style: TextStyle(fontSize: 18, color: Colors.grey))); // Handle empty data
            }

            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]), // Adds dividers
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  elevation: 10, // More prominent shadow
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners for the card
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      child: Icon(Icons.shopping_cart, color: Colors.white),
                    ),
                    title: Text(
                      data.product_name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87, // Darker text for better contrast
                      ),
                    ),
                    subtitle: Text(
                      "\Rp.${data.price}, ${data.category}",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic, // Subtle emphasis on category
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Detail(product: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormTambah()));
        },
        child: Icon(Icons.add, color: Colors.white),
        elevation: 12.0, // Adds more shadow to the FAB
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded FAB
        ),
        splashColor: Colors.orangeAccent, // Splash color effect
        hoverColor: Colors.orange[600], // Hover color
        tooltip: 'Add Product', // Tool tip text
      ),
    );
  }
}