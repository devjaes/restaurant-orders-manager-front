import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/config/helpers/get_tables.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/request_model.dart';

class RequestProvider extends ChangeNotifier {
  final TableAnswer _tableAnswer = TableAnswer();
  dynamic tables = [];
  List<RequestModel> requestList = [];

  RequestProvider() {
    _tableAnswer.getAllTables().then((value) {
      tables = value;
      tables.forEach((element) {
        requestList.add(RequestModel(id: element.id, tableId: element.id));
      });
    });
  }

  bool addRequest(RequestModel request) {
    try {
      requestList.add(request);
      print(requestList);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  bool removeRequest(RequestModel request) {
    try {
      requestList.remove(request);
      notifyListeners();
    } catch (e) {
      return false;
    }
    return true;
  }

  clearRequestList() {
    requestList = [];
    notifyListeners();
  }

  getRequests() {
    return requestList;
  }

  bool modifyRequest(int tableId, List<Map<String, dynamic>> productsRequest) {
    try {
      for (var element in requestList) {
        print('hola ${element.productsRequest} ${element.tableId == tableId}');
        if (element.tableId == tableId) {
          element.productsRequest.addAll(productsRequest);
          print('productsRequest: $productsRequest');
        }
      }
      notifyListeners();
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
  }

  RequestModel getRequestById(int id) {
    return requestList.firstWhere((element) => element.tableId == id);
  }

  // final RequestRepository _requestRepository = RequestRepository();

  // Future<List<Request>> getRequests() async {
  //   return await _requestRepository.getRequests();
  // }

  // Future<Request> getRequestById(String id) async {
  //   return await _requestRepository.getRequestById(id);
  // }

  // Future<Request> createRequest(Request request) async {
  //   return await _requestRepository.createRequest(request);
  // }

  // Future<Request> updateRequest(Request request) async {
  //   return await _requestRepository.updateRequest(request);
  // }

  // Future<void> deleteRequest(String id) async {
  //   await _requestRepository.deleteRequest(id);
  // }
}
