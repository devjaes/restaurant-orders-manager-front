class Request {
  final int id;
  final int tableId;
  List<Map<String, dynamic>> productsRequest = [];

  // final String productId;
  Request(this.tableId, {required this.id}) {
    productsRequest = [];
  }
}
