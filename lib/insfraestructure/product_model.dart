import 'package:restaurant_orders_manager_front/domain/entities/product_entity.dart';

class ProductModel {
  final int id;
  final String name;
  final double price;
  final bool availability;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.availability,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        availability: json['availability'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'price': price,
        'availability': availability,
      };

  Product toEntity() {
    return Product(
      id: id,
      name: name,
      price: price,
      availability: availability,
    );
  }
}
