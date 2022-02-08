import 'package:cloud_firestore/cloud_firestore.dart';

class ProductViewRepository {
  final userCollection = FirebaseFirestore.instance.collection('users');

  Future<List<String>> fetchCartProductIds(String userId) async {
    final user = userCollection.doc(userId);
    final cart = await user.collection('cart').get();

    if (cart.docs.isNotEmpty) {
      return cart.docs.map((value) => value.id).toList();
    } else {
      return [];
    }
  }

  // add product to cart in users collection in firestore database
  Future<void> addProductToCart(String productId, String userId) async {
    final user = userCollection.doc(userId);
    final cart = user.collection('cart');
    final cartItemToBeAdded = {
      'productId': productId,
      'quantity': 1,
    };
    await cart.doc(productId).set(cartItemToBeAdded);
  }

  // remove product to cart in users collection in firestore database
  Future<void> removeProductFromCart(String productId, String userId) async {
    final user = userCollection.doc(userId);
    final cart = user.collection('cart');

    await cart.doc(productId).delete();
  }
}
