import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_orders_manager_front/domain/entities/table_entity.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/table_model.dart';

class TableAnswer {
  final _dio = Dio();
  var logger = Logger();

  Future<List<CustomerTable>> getAllTables() async {
    final response = await _dio.get('${dotenv.env['API_URL']}tables');
    final List<TableModel> tables = (response.data as List)
        .map((table) => TableModel.fromJson(table))
        .toList();
    logger.i(tables.map((table) => table.toJson()).toList());
    return tables.map((table) => table.toEntity()).toList();
  }

  Future<void> takeTable(int tableId) async {
    final response = await _dio.patch(
      '${dotenv.env['API_URL']}tables/take/$tableId',
    );
    logger.i(response.data);
  }

  Future<void> emptyTable(int tableId) async {
    final response = await _dio.patch(
      '${dotenv.env['API_URL']}tables/empty/$tableId',
    );
    logger.i(response.data);
  }
}
