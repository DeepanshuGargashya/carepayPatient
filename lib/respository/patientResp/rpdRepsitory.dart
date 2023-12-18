import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class RpdRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> createRpd() async {
    print('hit respo');
    try {
      dynamic response =
          await _apiServices.getPostApiResponse('${AppUrl.createRpd}', []);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getRpdDetails(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getRpdDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
