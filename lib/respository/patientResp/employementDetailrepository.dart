import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class EmployementDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getEmploymentDetail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getEmployementDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> handleSubmitionApi(dynamic payload) async {
    print('hit respo');
    try {
      // dynamic response = await _apiServices.getPostApiResponse(
      //     '${AppUrl.generateAuthOtp}${data}', null);

      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateEmploymentDetails}', payload);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
