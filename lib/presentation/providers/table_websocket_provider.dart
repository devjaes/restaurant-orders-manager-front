// Archivo: table_websocket_provider.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/table_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import 'package:restaurant_orders_manager_front/domain/entities/table_entity.dart';

class TableWebSocketProvider extends ChangeNotifier {
  var logger = Logger();
  List<CustomerTable> tableList = [];
  List<CustomerTable> avaliableTableList = [];
  List<CustomerTable> notAvaliableTableList = [];
  late socket_io.Socket socket;

  TableWebSocketProvider() {
    _initializeWebSocketConnection();
  }

  void _initializeWebSocketConnection() {
    // Establece la conexión WebSocket aquí
    socket = socket_io.io(
      'ws://localhost:3000',
      socket_io.OptionBuilder().setTransports(['websocket']).build(),
    );

    // Escucha los eventos del servidor
    socket.onConnect((_) => logger.i('Connected to WebSocket server'));
    socket.on('update_tables', (data) => _handleTableUpdate(data));
    socket.onError((data) => logger.e('Error: $data'));

    // Cuando te conectes, puedes pedir el estado inicial de las mesas
    socket.onConnect((_) => socket.emit('get_initial_tables_state'));
  }

  void _handleTableUpdate(dynamic data) {
    // Actualiza tus listas de mesas aquí con los datos recibidos
    List<dynamic> tablesData = data is String ? json.decode(data) : data;
    tableList = tablesData
        .map((tableJson) => TableModel.fromJson(tableJson).toEntity())
        .toList();
    _sortTables();

    // Notifica a los oyentes después de actualizar el estado
    notifyListeners();
  }

  void _sortTables() {
    avaliableTableList.clear();
    notAvaliableTableList.clear();
    for (var table in tableList) {
      if (table.availability) {
        avaliableTableList.add(table);
      } else {
        notAvaliableTableList.add(table);
      }
    }
  }

  void takeTable(int tableId) {
    // En lugar de una llamada HTTP, envía un mensaje a través del WebSocket
    socket.emit('take_table', {'tableId': tableId});
  }

  void emptyTable(int tableId) {
    // Enviar mensaje para vaciar la mesa
    socket.emit('empty_table', {'tableId': tableId});
  }

  @override
  void dispose() {
    // Asegúrate de cerrar la conexión WebSocket cuando ya no se necesite
    socket.dispose();
    super.dispose();
  }
}
