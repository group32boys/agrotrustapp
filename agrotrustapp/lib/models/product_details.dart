class Product {
  final int sellerId;
  final String name;
  final String image;
  final String description;
  final double price;
  final double rating;
  final double unit;
  

  const Product ({
    required this.sellerId,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.rating,
    required this.unit,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      sellerId: json['sellerId'],
      name: json['name'],
      image: json['image'],
      description: json['description'],
      price: json['price'],
      rating: json['rating'],
      unit: json['unit'],
    );
  }
}