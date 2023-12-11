import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/domain/entities/table_entity.dart';
import 'package:restaurant_orders_manager_front/domain/entities/user_entity.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/product_provider.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/table_provider.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/user_provider.dart';

import 'waiter_products_categories.dart';

class WaiterDashboard extends StatelessWidget {
  const WaiterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableProvider()),
      ],
      child: Consumer<UserProvider>(
        builder: (context, userProvider, child) {
          User? user = userProvider.user;

          return Scaffold(
            appBar: AppBar(
              title: Text('Bienvenido ${user!.firstName}'),
              backgroundColor: Colors.primaries[14],
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.primaries[14],
                  width: MediaQuery.of(context).size.width,
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mesas disponibles',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<TableProvider>(
                  builder: (context, tableProvider, child) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tableProvider.avaliableTableList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: AvaliableTable(
                              table: tableProvider.avaliableTableList[index],
                              onPressed: () async {
                                await tableProvider.takeTable(
                                  tableProvider.avaliableTableList[index].id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Container(
                  color: Colors.primaries[14],
                  width: MediaQuery.of(context).size.width,
                  child: const SizedBox(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Mesas ocupadas',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Consumer<TableProvider>(
                  builder: (context, tableProvider, child) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tableProvider.notAvaliableTableList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: NotAvaliableTable(
                              table: tableProvider.notAvaliableTableList[index],
                              onPressed: () async {
                                await tableProvider.emptyTable(
                                  tableProvider.notAvaliableTableList[index].id,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class AvaliableTable extends StatelessWidget {
  final VoidCallback onPressed;
  final CustomerTable table;
  const AvaliableTable(
      {super.key, required this.table, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://www.visitfinland.com/dam/jcr:7c2c8221-ace3-4362-a5b0-8073ee6967e9/Savoy-Interior-7.jpeg', // Reemplace con su ruta de activos
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Mesa número ${table.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('No. asientos: ${table.size}'),
                  ],
                ),
              ),
            ),
            // Botón de acción
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange, // Text Color (Foreground color)
              ),
              child: const Text('Ocupar mesa'),
            ),
          ],
        ),
      ),
    );
  }
}

class NotAvaliableTable extends StatelessWidget {
  final CustomerTable table;
  final VoidCallback onPressed;

  const NotAvaliableTable(
      {super.key, required this.table, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                'https://www.visitfinland.com/dam/jcr:7c2c8221-ace3-4362-a5b0-8073ee6967e9/Savoy-Interior-7.jpeg', // Reemplace con su ruta de activos
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Mesa número ${table.id}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('No. asientos: ${table.size}'),
                  ],
                ),
              ),
            ),
            // Botón de acción
            Column(
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.orange, // Text Color (Foreground color)
                  ),
                  child: const Text('Desocupar mesa'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WaiterProductView(
                            tableId: table.id, key: UniqueKey()),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                        Colors.orange, // Text Color (Foreground color)
                  ),
                  child: const Text('Orden'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
