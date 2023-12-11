import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:restaurant_orders_manager_front/domain/entities/user_entity.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/UserModel.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LogInAnswer {
  final _dio = Dio();
  int count = 0;
  var logger = Logger();

  Future<User?> logIn({required String user, required String password}) async {
    final response = await _dio.post(
      '${dotenv.env['API_URL']}auth/login',
      data: {'user': user, 'password': password},
    );

    if (response.statusCode != 200 ||
        response.data.toString() == 'NOT_FOUND_EMPLOYEE' ||
        response.data.toString() == 'INVALID_PASSWORD') {
      count++;
      return null;
    }

    final UserModel userLogged = UserModel.fromJson(response.data);

    logger.i(userLogged.toJson());
    return userLogged.toEntity();
  }
}
