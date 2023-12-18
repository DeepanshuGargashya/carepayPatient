import 'dart:convert';

import 'package:CarePay/respository/patientResp/bankStatementRepository.dart';
// import 'package:CarePay/screens/patientScreens/bankAccountStatement.dart';
// import 'package:CarePay/screens/patientScreens/creditDetailScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/loader.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;

class BankStatementController with ChangeNotifier {
  final _myRepo = BankStatementRepository();

  final passwordController = TextEditingController();

  var _firstMonth = '';
  get firstMonth => _firstMonth;
  var _firstMonthName = '';
  get firstMonthName => _firstMonthName;

  var _secondMonth = '';
  get secondMonth => _secondMonth;
  var _secondMonthName = '';
  get secondMonthName => _secondMonthName;

  var _thirdMonth = '';
  get thirdMonth => _thirdMonth;
  var _thirdMonthName = '';
  get thirdMonthName => _thirdMonthName;

  var _userId;
  get userId => _userId;

  var _context;
  get context => _context;

  var _response = null;
  get response => _response;

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  void setEmpty(value) {
    if (value == "first") {
      _firstMonth = '';
      _firstMonthName = '';
      notifyListeners();
    } else if (value == "second") {
      _secondMonth = '';
      _secondMonthName = '';
      notifyListeners();
    } else {
      _thirdMonth = '';
      _thirdMonthName = '';
      notifyListeners();
    }
  }

  void openFiles(type) async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // dynamic doctorId = pref.getString('doctorId');

    FilePickerResult? resultFile = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (resultFile != null) {
      // Loader().fetchData(context);
      PlatformFile file = resultFile.files.first;
      if (type == "firstMonth") {
        _firstMonth = file.path!;
        _firstMonthName = file.name.toString();
      } else if (type == "secondMonth") {
        // _chequeError = false;
        _secondMonth = file.path!;
        _secondMonthName = file.name.toString();
      } else {
        _thirdMonth = file.path!;
        _thirdMonthName = file.name.toString();
      }
      notifyListeners();
      // var response = await _myRepo.handleUploading(
      //   file.path,
      // );
      // print("controller rsponse");
      // print(response);
      // try {
      //   http.Response.fromStream(response).then((onValue) {
      //     print(onValue);
      //     var str = onValue.body;
      //     if (response.statusCode == 200) {
      //       print(str);
      //       if (str.contains("downloadpdf?downloadfile=")) {
      //         if (type == "multipleBankStatement") {
      //           _firstMonth = str;
      //         } else if (type == "multipleBankStatement") {
      //           // _chequeError = false;
      //           _secondMonth = str;
      //         } else {
      //           _thirdMonth = str;
      //         }
      //         notifyListeners();
      //         Utils.successToastMessage('successfully uploaded');
      //         Loader().loaderClose(context);
      //       } else {
      //         Utils.toastMessage('unable To upload pic');
      //         Loader().loaderClose(context);
      //       }
      //     } else {
      //       Utils.toastMessage('unable To upload pic');
      //       Loader().loaderClose(context);
      //     }
      //   });
      // }

      // catch (e) {
      //   Utils.toastMessage('Please try again later');
      //   Loader().loaderClose(context);
      // }
      // Loader().loaderClose(context);
    } else {}
  }

  void initFetchData(context) async {
    // Loader().fetchData(context);
    _context = context;
    print('initS');
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    // dynamic getDoctorId = pref.getString('doctorId');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId');
    // var res = await _myRepo.getBankStatementDetail(userId.toString());
    // _response = res['data'];
    // print(res['data']);

    // //   setState(() {
    // setController(res['data']);
    notifyListeners();
    // Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      if (response['multipleBankStatements'] != null ||
          response['multipleBankStatements'] != '') {
        var multipleBankStatement =
            response['multipleBankStatements'].toString().split(',');

        if (multipleBankStatement.length > 0) {
          for (var i = 0; i < multipleBankStatement.length; i++) {
            if (i == 0) {
              _firstMonth = multipleBankStatement[0].toString();
              _firstMonthName = 'BankStatement 1';
            } else if (i == 1) {
              _secondMonth = multipleBankStatement[1].toString();
              _secondMonthName = 'BankStatement 2';
            } else if (i == 2) {
              _thirdMonth = multipleBankStatement[2].toString();
              _thirdMonthName = 'BankStatement 3';
            }
          }
          passwordController.text = response['bankStatementPassword'] != null
              ? response['bankStatementPassword'].toString()
              : "";
        }
        notifyListeners();
      }
    }
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString('userId');
      var payload;
      print("response");
      print(userId.toString());
      print(response);
      if (response != null && response != "") {
        print("inside if");
        payload = {
          ...response,
          "userId": userId.toString(),
          "fileName": "multipleBankStatement",
          "uploadfile1": firstMonth.toString(),
          "uploadfile2": secondMonth.toString(),
          "uploadfile3": thirdMonth.toString(),
          "password": passwordController.text.toString()
        };
      } else {
        payload = {
          "userId": userId.toString(),
          "fileName": "multipleBankStatement",
          "uploadfile1": firstMonth.toString(),
          "uploadfile2": secondMonth.toString(),
          "uploadfile3": thirdMonth.toString(),
          "password": passwordController.text.toString()
        };
      }
      print("payload");
      print(payload);
      var res = await _myRepo.handleUploading(payload);
      print(res);
      try {
        http.Response.fromStream(res).then((onValue) {
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
        print("error");
        print(e);
      }
    } catch (e) {
      print(e);
      Loader().loaderClose(context);
      Utils.toastMessage("Check Internet Connection");
    }
  }

  setPasswordVisible(type) {
    if (type.toString() == "pass") {
      _passwordVisible = !passwordVisible;
    }
    notifyListeners();
  }
}
