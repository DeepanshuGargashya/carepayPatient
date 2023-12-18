import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class PersonalDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getBasicDetails(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getBasicDetails}${data.toString()}');
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
          '${AppUrl.updatePersonalDetails}', payload);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
