import 'package:CarePay/respository/patientResp/makePaymentRepository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MakePaymentController with ChangeNotifier {
  final _myRepo = MakePaymentRepository();

  var _response = null;
  get response => _response;

  void initFetchData(BuildContext context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var userId = pref.getString('userId').toString();
    // var userId = "ywO7ZkVZxNThaIENT7FsP2tcFMOO7qTg";

    var res = await _myRepo.getCreditDetails(userId.toString());
    print(res);
    if (res['status'] == 200) {
      _response = res['data'];
      notifyListeners();
    }
  }
}
