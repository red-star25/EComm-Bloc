import 'package:equatable/equatable.dart';

class Product extends Equatable {
  const Product({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.subtitle,
    required this.price,
    required this.id,
  });

  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String price;
  final String id;

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      subtitle: json['subtitle'] as String,
      id: json['id'] as String,
    );
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        description,
        imageUrl,
        price,
        id,
      ];
}
