import 'package:flutter/material.dart';
import '../urun.dart';

class CartProvider extends ChangeNotifier {
  final List<Urun> _items = [];

  List<Urun> get items => _items;

  double get totalPrice =>
      _items.fold(0.0, (sum, product) => sum + product.fiyat);

  void addProduct(Urun product) {
    _items.add(product);
    notifyListeners();
  }

  void removeProduct(Urun product) {
    _items.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
