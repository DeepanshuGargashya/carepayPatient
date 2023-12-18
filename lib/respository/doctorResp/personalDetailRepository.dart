import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class PersonalDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> personalDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getPostApiResponse(
          '${AppUrl.updateDoctorPersonalDetails}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getPersonalDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorDetailsByPhoneNumber}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

// Future<dynamic> verifyOtpApi(dynamic phone, dynamic otp) async {
//   try {
//     dynamic response = await _apiServices.getPostApiResponse(
//         '${AppUrl.verifyOtp}?mobile=${phone.toString()}&otp=${otp.toString()}',
//         null);
//     return response;
//   } catch (e) {
//     throw e;
//   }
// }
}
