import 'package:restaurant_orders_manager_front/domain/entities/request_entity.dart';

class RequestModel {
  final String id;
  final String tableId;
  List<Map<String, dynamic>> productsRequest = [];

  RequestModel(
      {required this.tableId,
      required this.id,
      this.productsRequest = const []});

  // factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
  //       json["tableId"],
  //       id: json["id"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "tableId": tableId,
  //     };

  // toEntity() => RequestModel(
  //       tableId,
  //       id: id,
  //     );
}
