import 'package:logger/logger.dart';
import 'package:restaurant_orders_manager_front/domain/repositories/ws_repository.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

class WsRepositoryImpl implements WsRepository {
  var logger = Logger();
  socket_io.Socket? _socket;

  WsRepositoryImpl() {
    _socket = socket_io.io(
      'http://localhost:3000',
      socket_io.OptionBuilder()
          .setTransports(['websocket']) // for Flutter or Dart VM
          .enableAutoConnect()
          .build(),
    );

    _socket!.onConnect((_) {
      logger.i('connect');
      _socket!.emit('msg', 'test');
    });

    _socket!.onDisconnect((_) => logger.i('disconnect'));
    _socket!.onError((data) => logger.e('Error: $data'));
  }

  @override
  Future<bool> connect() async {
    try {
      _socket!.connect();
      return true; // Consider checking actual connection status
    } catch (e) {
      logger.e(e);
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    try {
      _socket!.disconnect();
    } catch (e) {
      logger.e(e);
    }
  }
}
