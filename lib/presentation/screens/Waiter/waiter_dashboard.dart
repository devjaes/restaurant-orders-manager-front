import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/user_provider.dart';

class WaiterDashboardScreen extends StatelessWidget {
  const WaiterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    return Scaffold(
      body: Center(
        child: Text(userProvider.user?.firstName ?? 'Waiter Dashboard'),
      ),
    );
  }
}
