import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class ProfessionalDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();

  Future<dynamic> professionalDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateDoctorProfessionalDetails}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getProfessionalDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorProfessionalDetailsByDoctorId}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
