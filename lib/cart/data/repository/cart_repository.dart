import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/cart/data/model/cart_product.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepository {
  final firestore = FirebaseFirestore.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');
  final productCollection = FirebaseFirestore.instance.collection('products');
  final cartCollection = FirebaseFirestore.instance.collection('cart');
  // fetch cart product from users collection in firestore database and return list of product ids
  Future<List<Map<String, dynamic>>> fetchCartProductIds() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(Preferences.user_id);
    final user = userCollection.doc(userId);
    final cart = await user.collection('cart').get();

    if (cart.docs.isNotEmpty) {
      return cart.docs.map((e) => e.data()).toList();
    } else {
      return [];
    }
  }

  Future<List<CartProduct>> fetchCartProduct(
    List<Map<String, dynamic>> productIds,
  ) async {
    final products = <CartProduct>[];
    for (var i = 0; i < productIds.length; i++) {
      final product = await getCartProductFromId(
        productIds[i]['productId'] as String,
        productIds[i]['quantity'] as int,
      );
      products.add(product);
    }
    return products;
  }

  Future<CartProduct> getCartProductFromId(String id, int quantity) async {
    final fetchedProduct = await productCollection.doc(id).get().then((value) {
      final cartData = value.data();
      cartData!['quantity'] = quantity;
      return CartProduct.fromMap(cartData);
    });
    return fetchedProduct;
  }

  //update cart product quantity in firestore database and return updated product
  Future<CartProduct> updateCartProduct(
    String productId,
    int quantity,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(Preferences.user_id);
    final product = await getCartProductFromId(productId, quantity);
    final user = userCollection.doc(userId);
    final cart = await user.collection('cart').get();
    final cartDoc =
        cart.docs.firstWhere((e) => e.data()['productId'] == productId);
    await cartDoc.reference.update({'quantity': quantity});
    return product;
  }

  //delete cart product from firestore database
  Future<void> deleteCartProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(Preferences.user_id);
    final user = userCollection.doc(userId);
    final cart = await user.collection('cart').get();
    final cartDoc =
        cart.docs.firstWhere((e) => e.data()['productId'] == productId);
    await cartDoc.reference.delete();
  }
}
