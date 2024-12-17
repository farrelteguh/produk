class ProdukModel {
  final int id;
  final String product_name; // Nama produk
  final String category; // Kategori produk
  final double price; // Harga produk
  final String description; // Deskripsi produk
  final String? imageUrl; // Nullable field untuk URL gambar produk

  ProdukModel({
    required this.id,
    required this.product_name,
    required this.category,
    required this.price,
    required this.description,
    this.imageUrl, // Optional URL field untuk gambar produk
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json) {
    return ProdukModel(
      id: json['id'] ?? 0, // Default to 0 if id is not present
      product_name: json['product_name'] ?? '', // Default to empty string if productName is not present
      category: json['category'] ?? '', // Default to empty string if category is not present
      price: double.parse(json['price'].toString()), // Parse price as double
      description: json['description'] ?? '', // Default to empty string if description is not present
      imageUrl: json['imageUrl'] ?? '', // Default to empty string if imageUrl is not present
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'product_name': product_name,
    'category': category,
    'price': price,
    'description': description,
    'imageUrl': imageUrl ?? '', // Convert null to empty string if needed
  };
}