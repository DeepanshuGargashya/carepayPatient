import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class DoctorBankDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> bankDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateDoctorBankDetails}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getBankDetailsByIFSC(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getBankDetailsByIFSC}${data.toString()}&type=branch');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getBankDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorBankDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
