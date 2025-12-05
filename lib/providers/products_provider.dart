import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final productsProvider = Provider<List<Product>>((ref) {
  return [
    Product(id: '1', name: 'Broccoli', price: 100),
    Product(id: '2', name: 'Banana', price: 30),
    Product(id: '3', name: 'Potatoes', price: 25),
  ];
});
