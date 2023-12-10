import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/domain/entities/user_entity.dart';

class UserProvider extends ChangeNotifier {
  User? user;

  UserProvider();

  void setUser(User user) {
    this.user = user;
    notifyListeners();
  }

  void clearUser(String id) {
    user = null;
    notifyListeners();
  }
}
