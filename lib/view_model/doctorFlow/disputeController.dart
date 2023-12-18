import 'dart:convert';

import 'package:CarePay/respository/doctorResp/raiseDisputeRepository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loader.dart';
import '../../utils/utils.dart';

class DisputeController with ChangeNotifier {
  final _myRepo = RaiseDisputeRepository();

  TextEditingController descriptions = TextEditingController();
  // TextEditingController screenshot = TextEditingController();

  var _screenshot = '';
  get screenshot => _screenshot;

  var _doctorId = null;
  get doctorId => _doctorId;

  var _loanId = null;
  get loanId => _loanId;

  late BuildContext _context;
  get context => _context;

  void initFetchData(context) async {
    // Loader().fetchData(context);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    // dynamic getLoanId = pref.getString('loanId');
    _doctorId = getDoctorId;
    // _loanId = getLoanId;
    print(_doctorId);
    // print("hii");
    // print(_loanId);
    // print("hiiii");
    notifyListeners();
    // Loader().loaderClose(context);
  }

  void openFiles(type) async {
    FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if (resultFile != null) {
      // Loader().fetchData(context);
      PlatformFile file = resultFile.files.first;
      _screenshot = file.path!;
      notifyListeners();
      print('_screenshot');
      print(file);
      print(file.path);
      print(screenshot);
      //   var response = await _myRepo.handleUploading(
      //       file.path, doctorId.toString(), type.toString());
      //   print("controller rsponse");
      //   print(response);
      //   try {
      //     http.Response.fromStream(response).then((onValue) {
      //       print(onValue);
      //       // print(onValue.body);
      //
      //       var str = onValue.body;
      //
      //       if (response.statusCode == 200) {
      //         print(str);
      //         if (str.contains("downloadpdf?downloadfile=")) {
      //           // if (type == "panCard") {
      //           //   _panCardUploadName = str;
      //           // } else if (type == "other") {
      //           //   _chequeError = false;
      //           //   _chequeUploadName = str;
      //           // } else {
      //           //   _gstindUploadName = str;
      //           // }
      //           notifyListeners();
      //           Utils.successToastMessage('successfully uploaded');
      //           Loader().loaderClose(context);
      //         } else {
      //           Utils.toastMessage('unable To upload pic');
      //           Loader().loaderClose(context);
      //         }
      //       } else {
      //         Utils.toastMessage('unable To upload pic');
      //         Loader().loaderClose(context);
      //       }
      //     });
      //   } catch (e) {
      //     Utils.toastMessage('Please try again later');
      //     Loader().loaderClose(context);
      //   }
      //   // Loader().loaderClose(context);
      //
      //   //   print(file.path);
      //   // print(file.name);
      //   // print(file.bytes);
      //   // print(file.extension);
      //   // print(file.path);
    }
    // else {}
  }

  handleSubmition(BuildContext context, loanId, userId) async {
    Loader().fetchData(context);
    try {
      var payload = {
        "doctorId": doctorId.toString(),
        "loanId": loanId.toString(),
        "userId": userId.toString(),
        "description": descriptions.text.toString(),
        "title": descriptions.text.toString(),
        "image": screenshot
        // "imageUrl": descriptions.toString(),
      };
      print("payload");
      print(payload);
      var res = await _myRepo.handleUploading(payload);
      print("res");
      // print(res);
      try {
        http.Response.fromStream(res).then((onValue) {
          print("Onvalue");
          print(onValue);
          // print(onValue.body);

          var str = onValue.body;
          print(str);
          var response = jsonDecode(str);
          print(response);
          // print(response.data);
          print(response['data']);

          // print(str.data);
          // print(str['data']);

          print(res);
          if (response['status'] == 200) {
            if (str.contains("downloadpdf?downloadfile=")) {
              Loader().loaderClose(context);
              Utils.updateSucessfully(context, "Dispute has been sent", "Okay");
              descriptions.clear();
              // "image".clear();
              _screenshot = "";
              notifyListeners();
              // Navigator.push(
              //   context,
              //   PageTransition(
              //       type: PageTransitionType.rightToLeftWithFade,
              //       child: CreditDetailScreen()),
              // );
            } else {
              Utils.toastMessage(res['data'].toString());
              Loader().loaderClose(context);
            }
            // Navigator.push(
            //     context,
            //     PageTransition(
            //         type: PageTransitionType.rightToLeftWithFade,
            //         child: BankAccountStatementScreen()));
          } else {
            Utils.toastMessage(res['data'].toString());
            Loader().loaderClose(context);
          }
        });
      } catch (e) {
        Loader().loaderClose(context);
        print("error");
        print(e);
      }
    } catch (e) {
      Loader().loaderClose(context);
      print(e);
      // Loader().loaderClose(context);
      Utils.toastMessage("Check Internet Connection");
    }
  }
}
