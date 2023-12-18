import 'package:CarePay/respository/patientResp/kycVerificationRepository.dart';
// import 'package:CarePay/screens/patientScreens/congratulation.dart';
import 'package:CarePay/utils/utils.dart';
// import 'package:CarePay/view_model/patientFlow/kycVerificationController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnderProcessController with ChangeNotifier {
  final _myRepo = KYCVerificationRepository();
  String? _number = "";
  String? get number => _number;

  late BuildContext _context;
  get context => _context;

  var _response = null;
  get response => _response;

  void initFetchData(context) async {
    _context = context;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _number = pref.getString('number');
    var userId = pref.getString('userId');
    var res = await _myRepo.getCreditDetails(userId.toString());
    print(res);
    if (res['status'] == 200) {
      _response = res['data'];
      notifyListeners();
    }
    notifyListeners();
  }

  void loanDetailsGet(BuildContext context) async {
    _context = context;
    notifyListeners();
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString('userId').toString();
      var res = await _myRepo.getInitiateFlowApi(
          userId.toString(), "loan_details_get");
      if (res['status'] == 200) {
        print("inside status");
        print(res['status']);
        if (res['data'][0]['loan_status'].toString() == "DISBURSED" ||
            res['data'][0]['loan_status'].toString() == "PASSED") {
          //  Navigate to congratulations

          // Navigator.push(
          //   context,
          //   PageTransition(
          //       type: PageTransitionType.rightToLeftWithFade,
          //       child: CongratulationScreen()),
          // );
        } else {
          print("inside else");
          // Navigator.pop(context);
          Utils.toastMessage(
              "status is ${res['data'][0]['loan_status'].toString()} yet");
        }
      } else {
        Navigator.pop(context);
        print("inside data null");
        Utils.toastMessage(res['data'].length > 0
            ? res['data'].toString()
            : "Please Try Again");
      }
    } catch (e) {
      Navigator.pop(context);
      print("inside catch");
      print(e);
    }
  }
}
