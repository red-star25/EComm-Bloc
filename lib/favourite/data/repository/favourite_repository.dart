import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouriteRepository {
  final firestore = FirebaseFirestore.instance;
  final productCollectionRef =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> fetchFavouriteProduct() async {
    final products = <Product>[];
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(Preferences.user_id);
    final DocumentSnapshot documentSnapshot =
        await firestore.collection('users').doc(userId).get();

    if (documentSnapshot.exists) {
      await firestore
          .collection('users')
          .doc(userId)
          .collection('favourite')
          .get()
          .then((value) async {
        if (value.docs.isNotEmpty) {
          for (var i = 0; i < value.docs.length; i++) {
            final product = await getProductFromId(value.docs[i].id);
            products.add(product);
          }
          return products;
        }
      });
    }
    return [];
  }

  Future<Product> getProductFromId(String id) async {
    final fetchedProduct =
        await productCollectionRef.doc(id).get().then((value) {
      return Product.fromMap(value.data()!);
    });
    return fetchedProduct;
  }

  Future<void> deleteFavourite({
    required String productId,
    required BuildContext context,
  }) async {
    final userId = RepositoryProvider.of<AppRepository>(context).userId;
    final userCollectionRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('favouriteProducts');
    try {
      await userCollectionRef.doc(productId).delete();
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }
}
