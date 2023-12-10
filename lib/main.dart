import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/config/helpers/getLogin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_orders_manager_front/presentation/screens/login.dart';

import 'presentation/screens/Waiter/waiter_dashboard.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login Screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/waiter_dashboard': (context) => const WaiterDashboardScreen(),
      },
    );
  }
}
