enum Roles {
  ADMINISTRADOR,
  CHEF,
  MESERO,
  CAJERO,
}

class User {
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

  User({
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
}
