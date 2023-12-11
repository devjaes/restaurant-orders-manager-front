// To parse this JSON data, do
//
//     final tableModel = tableModelFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant_orders_manager_front/domain/entities/table_entity.dart';

List<TableModel> tableModelFromJson(String str) =>
    List<TableModel>.from(json.decode(str).map((x) => TableModel.fromJson(x)));

String tableModelToJson(List<TableModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableModel {
  final int id;
  final int size;
  final bool availability;

  TableModel({
    required this.id,
    required this.size,
    required this.availability,
  });

  factory TableModel.fromJson(Map<String, dynamic> json) => TableModel(
        id: json['id'],
        size: json['size'],
        availability: json['availability'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'size': size,
        'availability': availability,
      };

  CustomerTable toEntity() {
    return CustomerTable(
      id: id,
      size: size,
      availability: availability,
    );
  }
}
