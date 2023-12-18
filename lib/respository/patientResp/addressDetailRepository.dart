import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class AddressDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getAddressDetail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getAddressDetail}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> handleSubmitionApi(dynamic payload) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateAddressDetails}', payload);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getDetailsByPinCode(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDetailsByPincode}${data.toString()}&type=zip');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
