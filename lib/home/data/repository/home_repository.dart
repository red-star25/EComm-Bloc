import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/data/repository/app_repository.dart';
import 'package:ecomm/data/sharedprefs/constants.dart';
import 'package:ecomm/home/data/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRepository {
  final firestore = FirebaseFirestore.instance;
  final productCollectionRed =
      FirebaseFirestore.instance.collection('products');
  final userCollectionRef = FirebaseFirestore.instance.collection('users');

  List<Product> productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Product.fromMap(e.data()! as Map<String, dynamic>);
    }).toList();
  }

  Stream<List<Product>> get products {
    return productCollectionRed.snapshots().map(productListFromSnapshot);
  }

  Future<List<String>> getFavProductAndCheckIfIsFav(
    String productId,
    BuildContext context,
  ) async {
    final productIdList = <String>[];
    final prefs = await SharedPreferences.getInstance();
    await userCollectionRef
        .doc(prefs.getString(Preferences.user_id))
        .collection('favouriteProducts')
        .get()
        .then((value) {
      value.docs.map((e) {
        productIdList.add(e.data()['productId'] as String);
      }).toList();
    });
    return productIdList;
  }

  Future<void> updateFavourite(
    String productId,
    BuildContext context, {
    required bool isFavourite,
  }) async {
    final userId = RepositoryProvider.of<AppRepository>(context).userId;
    if (isFavourite) {
      final updatedData = {'productId': productId};
      try {
        await userCollectionRef
            .doc(userId)
            .collection('favouriteProducts')
            .doc(productId)
            .set(updatedData);
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    } else {
      try {
        await userCollectionRef
            .doc(userId)
            .collection('favouriteProducts')
            .doc(productId)
            .delete();
      } on Exception catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
