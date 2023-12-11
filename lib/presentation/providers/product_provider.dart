import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/config/helpers/get_products.dart';
import 'package:restaurant_orders_manager_front/domain/entities/product_entity.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> tableList = [];

  ProductProvider() {
    getAllProducts();
  }

  getAllProducts() async {
    ProductAnswer productAnswer = ProductAnswer();
    tableList = await productAnswer.getAllProducts();
    notifyListeners();
  }
}
