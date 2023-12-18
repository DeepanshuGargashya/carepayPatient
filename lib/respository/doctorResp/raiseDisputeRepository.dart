import 'dart:convert';

import 'package:CarePay/data/network/BaseApiServices.dart';
import 'package:CarePay/data/network/NetworkApiService.dart';
import 'package:CarePay/res/app_url.dart';
import 'package:http/http.dart' as http;
import '../../utils/utils.dart';

class RaiseDisputeRepository {
  BaseApiServices _apiServices = NetworkApiService();

  handleUploading(data) async {
    // print(uploadFile.toString());
    // print(doctorId.toString());
    // print(fileName.toString());
    // Navigator.pop(context);
    try {
      var request =
      http.MultipartRequest("POST", Uri.parse(AppUrl.raiseDispute));
      request.headers.addAll({});

      if (data['image'].toString().length > 4) {
        request.files.add(await http.MultipartFile.fromPath(
            'image', data['image']));
      }

      // request.fields['detailPO'] = json.encode({
      //   "loanId":data['loanId'],
      //   "doctorId":data['doctorId'],
      //   "description":data['description'],
      //   "title":data['title']
      //   });
      request.fields['loanId'] = data['loanId'].toString();
      request.fields['doctorId'] = data['doctorId'].toString();
      request.fields['userId'] = data['userId'].toString();
      request.fields['description'] = data['description'].toString();

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
}