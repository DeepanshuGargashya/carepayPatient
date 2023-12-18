import 'dart:convert';

import 'package:http/http.dart';
import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class KYCVerificationRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> getInitiateFlowApi(dynamic userId, dynamic type) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.getKYCVerificationStatus}${userId.toString()}&type=${type.toString()}',
          []);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getCreditDetails(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getCreditDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
