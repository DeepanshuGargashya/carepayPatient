import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';
import 'package:http/http.dart' as http;

import '../../utils/utils.dart';

class BankStatementRepository {
  BaseApiServices _apiServices = NetworkApiService();

  // bankStatementApi(uploadFile, userId, fileName) async  {
  //   print('hit respo');
  //   try {
  //     dynamic response = await _apiServices.getPostApiResponse(
  //         '${AppUrl.uploadBankStatement}','');
  //     print('respo response=>');
  //     return response;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  handleUploading(data) async {
    // print(uploadFile.toString());
    // print(doctorId.toString());
    // print(fileName.toString());
    // Navigator.pop(context);
    try {
      var request =
          http.MultipartRequest("POST", Uri.parse(AppUrl.uploadBankStatement));
      if (data['uploadfile1'].toString().length > 4) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploadfile', data['uploadfile1']));
      }
      if (data['uploadfile2'].toString().length > 4) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploadfile', data['uploadfile2']));
      }
      if (data['uploadfile3'].toString().length > 4) {
        request.files.add(await http.MultipartFile.fromPath(
            'uploadfile', data['uploadfile3']));
      }
      request.fields['userId'] = data['userId'].toString();
      request.fields['fileName'] = data['fileName'].toString();
      request.fields['password'] = data['password'].toString();
      print("request fields");
      print(request.fields);
      print(request.files);
      try {
        return await request.send().then((response) {
          print("respo response =>");
          return response;
        });
      } catch (e) {
        print("error in uploading");
        print(e);
        Utils.toastMessage("Unable To upload pic,Try Again");
      }
    } catch (e) {}
  }

  Future<dynamic> getBankStatementDetail(dynamic data) async {
    print('hit respo');
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('${AppUrl.getBankStatement}${data.toString()}');
      print('respo response=>');
      return response;
    } catch (e) {
      throw e;
    }
  }
}
