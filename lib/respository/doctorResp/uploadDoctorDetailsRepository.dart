import 'package:CarePay/utils/utils.dart';

import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';
import 'package:http/http.dart' as http;

class UploadDetailRepository {
  BaseApiServices _apiServices = NetworkApiService();
  handleUploading(uploadFile, doctorId, fileName, extension) async {
    // print(uploadFile.toString());
    // print(doctorId.toString());
    // print(fileName.toString());
    // Navigator.pop(context);

    try {
      var request =
          http.MultipartRequest("POST", Uri.parse(AppUrl.uploadDoctorDetails));
      request.files
          .add(await http.MultipartFile.fromPath('uploadfile', uploadFile));
      request.fields['userId'] = doctorId.toString();
      request.fields['fileName'] = fileName.toString();
      request.fields['type'] =
          extension.toString() == "pdf" ? extension.toString() : "img";
      print("request fields");
      print(request.fields);
      try {
        return await request.send().then((response) {
          return response;
        });
      } catch (e) {
        print("error in uploading");
        print(e);
        Utils.toastMessage("Unable To upload pic,Try Again");
      }
    } catch (e) {}
  }

  Future<dynamic> getAddressDetailApi(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getDoctorDetails}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> sendEmail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.addDoctorSendMail}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
