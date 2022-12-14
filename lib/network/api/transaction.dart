import 'dart:async';
import 'dart:ffi';
import 'package:money_manager/model/transactionModel.dart';
import '../dio_client.dart';
import '../endpoint/endpoint.dart';

class TransactionApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  TransactionApi(this._dioClient);

  Future<TransactionModel> createTransaction(
      String title,
      String idUser,
      String description,
      String amount,
      String category,
      String dateTime,
      bool isIncome) async {
    var data = {
      "idUser": idUser,
      "title": title,
      "description": description,
      "amount": amount,
      "isIncome": isIncome,
      "category": category,
      "dateTime": dateTime
    };

    try {
      final res =
          await _dioClient.post(Endpoints.createTransaction, data: data);
      var map = Map<String, dynamic>.from(res);
      var response = TransactionModel.fromMap(map);
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<TransactionModel> getOneTransaction(String id) async {
    var data = {"id": id};

    try {
      final res = await _dioClient.get(Endpoints.getOneTransaction,
          queryParameters: data);
      var map = Map<String, dynamic>.from(res);
      var response = TransactionModel.fromMap(map);
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<bool> deleteTransaction(String id) async {
    try {
      final res = await _dioClient.delete(Endpoints.deleteTransaction + id);
      var map = Map<String, dynamic>.from(res);
      if (map["success"] == true) {
        print("deleted success");
        return true;
      }
      return false;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<TransactionModel>> getAllTransaction() async {
    try {
      final response = await _dioClient.get(Endpoints.getAllTransaction);
      var result =
          (response as List).map((e) => TransactionModel.fromMap(e)).toList();
      return result;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<TransactionModel>> getTransactionRangeDate(
      String sDay, String eDay) async {
    var param = {"sDay": sDay + " 00:00:00:000", "eDay": eDay + " 23:59:59:000"};
    try {
      final response = await _dioClient.get(Endpoints.getTransactionRangeDate,
          queryParameters: param);
      var result =
          (response as List).map((e) => TransactionModel.fromMap(e)).toList();
      return result;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<TransactionModel> updateTransaction(
      String id,
      String title,
      String description,
      String amount,
      String category,
      String dateTime,
      bool isIncome) async {
    var data = {
      "title": title,
      "description": description,
      "amount": amount,
      "isIncome": isIncome,
      "category": category,
      "dateTime": dateTime,
    };

    try {
      final res =
          await _dioClient.put(Endpoints.updateTransaction + id, data: data);
      var map = Map<String, dynamic>.from(res);
      var response = TransactionModel.fromMap(map);
      return response;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }
}
