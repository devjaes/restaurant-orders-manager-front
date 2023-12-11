import 'package:restaurant_orders_manager_front/domain/entities/request_entity.dart';

class RequestModel {
  final int id;
  final int tableId;
  List<Map<String, dynamic>> productsRequest;

  RequestModel({
    required this.tableId,
    required this.id,
    List<Map<String, dynamic>>? initialProductsRequest,
  }) : productsRequest = initialProductsRequest ?? [];

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

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id, tableId: $tableId, productsRequest: $productsRequest';
  }
}
