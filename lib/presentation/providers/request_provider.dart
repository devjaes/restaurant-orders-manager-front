import 'package:flutter/material.dart';
import 'package:restaurant_orders_manager_front/insfraestructure/request_model.dart';

class RequestProvider extends ChangeNotifier {
  List<RequestModel> requestList = [];

  bool addRequest(RequestModel request) {
    try {
      requestList.add(request);
      notifyListeners();
    } catch (e) {
      return false;
    }
    return true;
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
      requestList.forEach((element) {
        if (element.tableId == tableId) {
          element.productsRequest.addAll(productsRequest);
          print(element.productsRequest);
        }
      });
      notifyListeners();
      return true;
    } catch (e) {
      print('error: $e');
      return false;
    }
    return false;
  }

  RequestModel? getRequestById(String id) {
    try {
      return requestList.firstWhere((element) => element.tableId == id);
    } catch (e) {
      return null;
    }
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
