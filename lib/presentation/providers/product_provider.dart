import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/config/helpers/get_products.dart';
import 'package:restaurant_orders_manager_front/domain/entities/product_entity.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> productList = [];

  ProductProvider() {
    getAllProducts();
  }

  getAllProducts() async {
    ProductAnswer productAnswer = ProductAnswer();
    productList = await productAnswer.getAllProducts();
    notifyListeners();
  }
}
