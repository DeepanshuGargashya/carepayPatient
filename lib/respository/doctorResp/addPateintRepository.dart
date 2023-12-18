import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';

class AddPatientRepository {
  BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> addPatientApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response =
          await _apiServices.getPostApiResponse('${AppUrl.addPatient}', data);
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendEmail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.addPatientSendMail}patientName=${data['patientName'].toString()}&emailId=${data['emailId'].toString()}&doctorId=${data['doctorId'].toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> getDoctorDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          '${AppUrl.getDoctorDetailsByDoctorId.toString()}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
