import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class HomeMainRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getDoctorDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorDetailsByDoctorId.toString()}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getDoctorLoanSummaryApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getLoanSummary.toString()}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getAllTransactionApi(dynamic doctorId, dynamic status) async {
    print('hit respo');
    print(doctorId);
    print(status);
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getAllTransactions}${doctorId.toString()}&status=${status.toString()}&pageNo=1&noOfEntry=3');
      // dynamic response = await _apiServices.getGetApiResponse(
      //     '${AppUrl.getAllTransactions}${data.toString()}&status=approved&pageNo=${page.toString()}&noOfEntry=2');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getGraphApi(
      dynamic doctorId, dynamic status, dynamic resultType) async {
    print('hit respo');
    try {
      // dynamic response = await _apiServices.getGetApiResponse(
      //     '${AppUrl.getGraph.toString()}${doctorId.toString()}&base=monthly&status=${status.toString()}&resultType=${resultType.toString()}');
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getGraph.toString()}${doctorId.toString()}&base=monthly&status=${status.toString()}&resultType=${resultType.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
