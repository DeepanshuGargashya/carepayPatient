import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class BankDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> handleSubmitionApi(dynamic payload) async {
    print('hit respo');
    try {
      // dynamic response = await _apiServices.getPostApiResponse(
      //     '${AppUrl.generateAuthOtp}${data}', null);

      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateBankDetails}', payload);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getBankDetail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getBankDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPatientBankDetailsByIFSC(dynamic data) async {
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
}
