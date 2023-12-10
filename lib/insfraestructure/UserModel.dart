// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:restaurant_orders_manager_front/domain/entities/user_entity.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String id;
  final String firstName;
  final String secondName;
  final String firstLastName;
  final String secondLastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String user;
  final String password;
  final Roles role;

  UserModel({
    required this.id,
    required this.firstName,
    required this.secondName,
    required this.firstLastName,
    required this.secondLastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.user,
    required this.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        firstName: json['firstName'],
        secondName: json['secondName'],
        firstLastName: json['firstLastName'],
        secondLastName: json['secondLastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        user: json['user'],
        password: json['password'],
        role: Roles.values.firstWhere(
          (element) => element.toString() == 'Roles.' + json['role'],
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'secondName': secondName,
        'firstLastName': firstLastName,
        'secondLastName': secondLastName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'user': user,
        'password': password,
        'role': role,
      };

  toEntity() => User(
        id: id,
        firstName: firstName,
        secondName: secondName,
        firstLastName: firstLastName,
        secondLastName: secondLastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        user: user,
        password: password,
        role: role,
      );
}
