import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();
}

class FormTambahState extends State<FormTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String _category = "";
  final List<String> categories = ['Electronics', 'Clothing', 'Food', 'Books', 'Furniture'];

  // For image
  Uint8List? _imageData; // Changed from File to Uint8List for compatibility
  final ImagePicker _picker = ImagePicker();

  // Function to pick image
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _imageData = bytes;
      });
    }
  }

  Future createProduct() async {
    var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1/produkk/create.php'));

    // Add text fields
    request.fields['product_name'] = productNameController.text;
    request.fields['category'] = _category;
    request.fields['price'] = priceController.text;
    request.fields['stock'] = stockController.text;
    request.fields['description'] = descriptionController.text;

    // Add image file if it exists
    if (_imageData != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        _imageData!,
        filename: 'upload_image.jpg', // or other filename
      ));
    }

    final response = await request.send();
    final res = await http.Response.fromStream(response);
    return json.decode(res.body);
  }

  void _onConfirm(context) async {
    final data = await createProduct();
    if (data['success']) {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Produk",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _textboxProductName(),
            _textboxCategory(),
            _textboxPrice(),
            _textboxStock(),
            _textboxDescription(),
            const SizedBox(height: 20.0),
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  _textboxProductName() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Product Name",
          prefixIcon: Icon(Icons.production_quantity_limits),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: productNameController,
      ),
    );
  }

  _textboxCategory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Category',
          prefixIcon: Icon(Icons.category),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        items: categories
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        value: _category.isEmpty ? null : _category,
        onChanged: (String? value) {
          setState(() {
            _category = value ?? '';
          });
        },
      ),
    );
  }

  _textboxPrice() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Price",
          prefixIcon: Icon(Icons.money_rounded),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: priceController,
        keyboardType: TextInputType.number,
      ),
    );
  }

  _textboxStock() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Stock",
          prefixIcon: Icon(Icons.storage),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: stockController,
        keyboardType: TextInputType.number,
      ),
    );
  }

  _textboxDescription() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Description",
          prefixIcon: Icon(Icons.description),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        controller: descriptionController,
        maxLines: 3,
      ),
    );
  }


  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () => _onConfirm(context),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 30.0),
        elevation: 5.0,
        shadowColor: Colors.grey.withOpacity(0.5),
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}