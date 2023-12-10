import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/config/helpers/get_tables.dart';
import 'package:restaurant_orders_manager_front/domain/entities/table_entity.dart';

class TableProvider extends ChangeNotifier {
  List<CustomerTable> tableList = [];
  List<CustomerTable> avaliableTableList = [];
  List<CustomerTable> notAvaliableTableList = [];

  TableProvider() {
    getAllTables();
  }

  getAllTables() async {
    TableAnswer tableAnswer = TableAnswer();
    tableList = await tableAnswer.getAllTables();
    sortTables();
    notifyListeners();
  }

  sortTables() async {
    for (var table in tableList) {
      if (table.availability) {
        avaliableTableList.add(table);
      } else {
        notAvaliableTableList.add(table);
      }
    }

    notifyListeners();
  }

  takeTable(int tableId) async {
    TableAnswer tableAnswer = TableAnswer();
    await tableAnswer.takeTable(tableId);
    clearTableList();
    getAllTables();
  }

  emptyTable(int tableId) async {
    TableAnswer tableAnswer = TableAnswer();
    await tableAnswer.emptyTable(tableId);
    clearTableList();
    getAllTables();
  }

  clearTableList() {
    tableList = [];
    avaliableTableList = [];
    notAvaliableTableList = [];
    notifyListeners();
  }
}
