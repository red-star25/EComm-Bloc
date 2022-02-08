import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  const CartProduct({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.subtitle,
    required this.price,
    required this.id,
    required this.quantity,
  });

  final String title;
  final String subtitle;
  final String description;
  final String imageUrl;
  final String price;
  final String id;
  final int quantity;

  factory CartProduct.fromMap(Map<String, dynamic> json) {
    return CartProduct(
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      price: json['price'] as String,
      subtitle: json['subtitle'] as String,
      id: json['id'] as String,
      quantity: json['quantity'] as int,
    );
  }

  //create toMap method
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'subtitle': subtitle,
      'id': id,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        description,
        imageUrl,
        price,
        id,
        quantity,
      ];
}
