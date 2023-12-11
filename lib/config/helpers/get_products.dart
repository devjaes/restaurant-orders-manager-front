import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_orders_manager_front/domain/entities/product_entity.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/product_model.dart';

class ProductAnswer {
  final _dio = Dio();
  var logger = Logger();

  Future<List<Product>> getAllProducts() async {
    final response = await _dio.get('${dotenv.env['API_URL']}products');
    final List<ProductModel> products = (response.data as List)
        .map((product) => ProductModel.fromJson(product))
        .toList();
    logger.i(products.map((product) => product.toJson()).toList());
    return products.map((product) => product.toEntity()).toList();
  }
}
