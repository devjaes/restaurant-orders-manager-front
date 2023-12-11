import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/product_model.dart';
import 'package:restaurant_orders_manager_front/presentation/providers/request_provider.dart';

import '../../../insfraestructure/request_model.dart';

class Products extends StatefulWidget {
  final ProductModel productCategory;
  final int tableId;
  const Products({
    super.key,
    required this.productCategory,
    required this.tableId,
  });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  List<int> quantities = []; // Lista de cantidades

  @override
  void initState() {
    super.initState();
    quantities = List<int>.filled(widget.productCategory.products.length, 0);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RequestProvider>(
      builder: (context, requestProvider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.productCategory.name),
            backgroundColor: Colors.primaries[14],
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.productCategory.products.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  widget.productCategory.products[index].name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.productCategory.products[index].price,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        setState(() {
                          quantities[index] =
                              quantities[index] > 0 ? quantities[index] - 1 : 0;
                        });
                      },
                    ),
                    Text(
                      '${quantities[index]}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          quantities[index]++;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              List<Map<String, dynamic>> productsRequest = [];
              for (var i = 0; i < widget.productCategory.products.length; i++) {
                if (quantities[i] > 0) {
                  productsRequest.add({
                    'productId': widget.productCategory.products[i].id,
                    'quantity': quantities[i],
                  });
                }
              }

              if (requestProvider.modifyRequest(
                widget.tableId,
                productsRequest,
              )) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pedido modificado'),
                    backgroundColor: Colors.green,
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Error al modificar el pedido'),
                  ),
                );
              }
              Navigator.pop(context, productsRequest);
            },
            label: const Text('Añadir'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.primaries[14],
          ),
        );
      },
    );
  }
}
