import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class CibilDataDecentro {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getCibilDataDecentro(dynamic data, dynamic userId) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getCibilDataDecentro}${userId.toString()}&name=${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
