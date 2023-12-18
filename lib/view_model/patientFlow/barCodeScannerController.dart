import 'package:CarePay/respository/doctorResp/homeMainRepository.dart';
import 'package:CarePay/screens/patientScreens/confirmationPage.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BarCodeScannerController with ChangeNotifier {
  final _myRepo = HomeMainRepository();

  var _previousId = "";
  get previousId => _previousId;

  void fetchDoctorDetails(context, doctorId) async {
    if (doctorId != null) {
      var splitUrl = [];
      splitUrl = doctorId.toString().split('/');
      print("splitUrl");
      print(splitUrl);
      print(splitUrl.length);
      print(splitUrl[splitUrl.length - 2]);
      print("inside pop condition");

      print("inside init fetch data of confirmation controller");
      if (previousId.toString() != splitUrl[splitUrl.length - 2].toString()) {
        var res = await _myRepo
            .getDoctorDetailApi(splitUrl[splitUrl.length - 2].toString());
        if (res['status'] == 200) {
          _previousId = splitUrl[splitUrl.length - 2].toString();
          notifyListeners();
          print(res);
          if (res['data'] != "" && res['data'] != null) {
            _previousId = "";
            notifyListeners();
            await Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: ConfirmationPage(
                      doctorRes: res['data'],
                      doctorId: splitUrl[splitUrl.length - 2].toString())),
            );
          } else {
            _previousId = splitUrl[splitUrl.length - 2].toString();
            notifyListeners();
            Utils.toastMessage("doctor have no details, try again");
          }
        }
      }
    }
  }
}
