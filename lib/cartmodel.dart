import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  List<Product> _cart = [];

  List<Product> get cartItems {
    return [..._cart];
  }

  void addProductCart(Product product) {
    var index = _cart.indexWhere((element) => element.id == product.id);
    if (index != -1) {
      updateProduct(product, product.qty + 1);
    } else {
      _cart.add(product);
      calculateTotal();
    }
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = _cart.indexWhere((i) => i.id == product.id);
    _cart[index].qty = qty;
    if (_cart[index].qty == 0) deleteProductCart(product);
    calculateTotal();
    notifyListeners();
  }

  void deleteProductCart(Product product) {
    _cart.remove(product);
    product.qty = 1;
    calculateTotal();
    notifyListeners();
  }

  double totalCartValue = 0;
  double calculateTotal() {
    totalCartValue = 0;
    _cart.forEach((product) {
      totalCartValue += product.price * product.qty;
    });
    notifyListeners();
    return totalCartValue;
  }

  void clearCart() {
    _cart.forEach((product) => product.qty = 1);
    _cart = [];
    notifyListeners();
  }
}

class Product {
  int id;
  String title;
  String imgUrl;
  double price;
  int qty;

  Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.qty,
      required this.imgUrl});
}

class ProductModel with ChangeNotifier {
  List<Product> _products = [
    Product(
        id: 1,
        title: "Apple",
        price: 20.0,
        imgUrl: "https://img.icons8.com/plasticine/2x/apple.png",
        qty: 1),
    Product(
        id: 2,
        title: "Banana",
        price: 40.0,
        imgUrl: "https://img.icons8.com/cotton/2x/banana.png",
        qty: 1),
    Product(
        id: 3,
        title: "Orange",
        price: 20.0,
        imgUrl: "https://img.icons8.com/cotton/2x/orange.png",
        qty: 1),
    Product(
        id: 4,
        title: "Melon",
        price: 40.0,
        imgUrl: "https://img.icons8.com/cotton/2x/watermelon.png",
        qty: 1),
    Product(
        id: 5,
        title: "Avocado",
        price: 25.0,
        imgUrl: "https://img.icons8.com/cotton/2x/avocado.png",
        qty: 1),
  ];

  List<Product> get products {
    return [..._products];
  }

  addNewProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}
