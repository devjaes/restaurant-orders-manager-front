import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/product_provider.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/request_provider.dart';
import 'package:restaurant_orders_manager_front/presentation/screens/Waiter/waiter_products.dart';

import '../../../insfraestructure/request_model.dart';

class WaiterProductView extends StatefulWidget {
  final int tableId;
  const WaiterProductView({required Key key, required this.tableId})
      : super(key: key);

  @override
  State<WaiterProductView> createState() => _WaiterProductViewState();
}

class _WaiterProductViewState extends State<WaiterProductView> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categorias de productos'),
          backgroundColor: Colors.primaries[14],
        ),
        body: Consumer<ProductProvider>(
          builder: (context, productProvider, child) {
            return Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: productProvider.productList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        productProvider.productList[index].name,
                        style: const TextStyle(
                          fontSize:
                              16, // Cambia esto al tamaño de fuente que quieras
                          fontWeight: FontWeight
                              .bold, // Cambia esto al peso de fuente que quieras
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.add,
                        ), // Cambia esto al icono que quieras
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Products(
                                productCategory:
                                    productProvider.productList[index],
                                tableId: widget.tableId,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: OrderView(
                    key: UniqueKey(),
                    tableId: widget.tableId,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class OrderView extends StatefulWidget {
  final int tableId;
  const OrderView({super.key, required this.tableId});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  RequestModel? request; // Mover la definición de 'request' aquí

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      updateRequest();
    });
  }

  void updateRequest() {
    request = Provider.of<RequestProvider>(context, listen: false)
        .getRequestById(widget.tableId);
    print(request?.productsRequest);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    updateRequest();

    return Consumer<RequestProvider>(
      builder: (context, requestProvider, child) {
        if (request != null && request!.productsRequest.isEmpty) {
          return const Text('No existen ordenes para esta mesa');
        } else {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: request!.productsRequest.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('${request!.productsRequest[index]}'),
                  );
                },
              ),
            ],
          );
        }
      },
    );
  }
}
