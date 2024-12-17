import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';

class AppForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController productNameController,
      categoryController,
      priceController,
      descriptionController,
      availabilityController;

  AppForm({
    required this.formkey,
    required this.productNameController,
    required this.categoryController,
    required this.priceController,
    required this.descriptionController,
    required this.availabilityController,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  String _availability = "";
  final _availabilityStatus = ["Available", "Out of Stock"];

  final List<String> categories = [
    'Electronics',
    'Furniture',
    'Clothing',
    'Food',
    'Books',
    'Toys',
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtProductName(),
            txtCategory(),
            txtPrice(),
            txtDescription(),
            txtAvailability(),
          ],
        ),
      ),
    );
  }

  txtProductName() {
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
      child: TextFormField(
        controller: widget.productNameController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Product Name",
          prefixIcon: Icon(Icons.shopping_cart),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter product name.';
          }
          return null;
        },
      ),
    );
  }

  txtCategory() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
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
        hint: const Text('Select Category'),
        items: categories
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        ))
            .toList(),
        value: widget.categoryController.text,
        onChanged: (String? value) {
          setState(() {
            selectedCategory = value;
            widget.categoryController.text = selectedCategory!;
          });
        },
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please select a category.';
          }
          return null;
        },
      ),
    );
  }

  txtPrice() {
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
      child: TextFormField(
        controller: widget.priceController,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: const InputDecoration(
          labelText: "Price",
          prefixIcon: Icon(Icons.money_rounded),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the product price.';
          }
          return null;
        },
      ),
    );
  }

  txtDescription() {
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
      child: TextFormField(
        controller: widget.descriptionController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Description",
          prefixIcon: Icon(Icons.description),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter the product description.';
          }
          return null;
        },
      ),
    );
  }

  txtAvailability() {
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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check_box),
              SizedBox(width: 10.0),
              Text(
                "Availability",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          RadioGroup<String>.builder(
            groupValue: widget.availabilityController.text,
            onChanged: (value) => setState(() {
              _availability = value ?? '';
              widget.availabilityController.text = _availability;
            }),
            items: _availabilityStatus,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
              textPosition: RadioButtonTextPosition.right,
            ),
            activeColor: Colors.purple,
            fillColor: Colors.purple,
          ),
        ],
      ),
    );
  }
}