import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/domain/entities/product_entity.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/user_provider.dart';
import 'package:restaurant_orders_manager_front/presentation/screens/Waiter/waiter_products.dart';
import 'package:restaurant_orders_manager_front/presentation/screens/Waiter/waiter_products_categories.dart';
import 'package:restaurant_orders_manager_front/presentation/screens/login.dart';

import 'presentation/providers/request_provider.dart';
import 'presentation/screens/Waiter/waiter_dashboard.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => RequestProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login Screen',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const LoginScreen(),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/waiter_dashboard': (context) => const WaiterDashboard(),
        },
      ),
    );
  }
}
