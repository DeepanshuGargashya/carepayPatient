import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class AllTransactionRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAllTransactionApi(
      dynamic data, dynamic page, dynamic status) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getAllTransactions}${data.toString()}&status=${status.toString()}&pageNo=${page.toString()}&noOfEntry=4');
      // dynamic response = await _apiServices.getGetApiResponse(
      //     '${AppUrl.getAllTransactions}${data.toString()}&status=approved&pageNo=${page.toString()}&noOfEntry=2');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getAllTransactionCountApi(
      dynamic data, dynamic status) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getAllTransactionsCount}${data.toString()}&status=${status.toString()}');
      // dynamic response = await _apiServices.getGetApiResponse(
      //     '${AppUrl.getAllTransactionsCount}${data.toString()}&status=${status.toString()}');
      print('respo response=>');
      return response['data'];
    } catch (e) {
      throw e;
    }
  }
}
