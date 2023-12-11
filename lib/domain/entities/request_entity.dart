class Request {
  final String id;
  final String tableId;
  final List<Map<String, dynamic>> productsRequest = [];

  // final String productId;
  Request(this.tableId, {required this.id});
}
