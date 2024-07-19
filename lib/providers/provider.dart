import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app_assignment/models/product.dart';
import 'package:e_commerce_app_assignment/services/database/firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';

class ProductProvider with ChangeNotifier{
  List<Product> _products = [];
  bool _isLoading = false;
  List<Product> _filteredProducts = [];
  final StreamController<List<Product>> _productStreamController = StreamController.broadcast();

  List<Product>get products => _products;
  bool get isLoading => _isLoading;
  List<Product> get filteredProducts => _filteredProducts;
  Stream<List<Product>> get productStream => _productStreamController.stream;

  ProductProvider(){
    fetchProducts();
  }

  void fetchProducts() async{
    _isLoading = true;
    notifyListeners();

    try{
      _products = await ProductService().fetchProducts();
      _productStreamController.add(_products);
      _filteredProducts = _products;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }

    _isLoading = false;
    notifyListeners();
  }

   void searchProducts(String query) {
    if (query.isEmpty) {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) => product.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }


  Future<void> addToCart(Product product) async {
    try {
      FirebaseFirestore.instance.collection('carts').add({
        'productId': product.id,
        'title': product.title,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'price': product.price,
      });
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}



class CartProvider with ChangeNotifier{
List<Product> _cartItems = [];
List<Product> get cartItems => _cartItems;

void  addToCart(Product product){
  _cartItems.add(product);
  saveCartToFirestore();
  notifyListeners();
}

void removeFromCart(Product product){
  _cartItems.remove(product);
  notifyListeners();
  saveCartToFirestore();
}

void saveCartToFirestore() async{
  var user = FirebaseAuth.instance.currentUser;
  if(user!=null){
    await FirebaseFirestore.instance.collection('carts').doc(user.uid).set({
      'items': _cartItems.map((item) => item.toJson()).toList(),
    });
  }
}

void loadCartFromFirestore() async{
  var user = FirebaseAuth.instance.currentUser;
  if(user!=null){
    var doc = await FirebaseFirestore.instance.collection('carts').doc(user.uid).get();

    if(doc.exists){
      var data = doc.data()!;
      var items = (data['items'] as List).map((item) => Product.fromJson(item)).toList();
      _cartItems = items;
      notifyListeners();
    }
  }
}

}