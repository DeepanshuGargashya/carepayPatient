import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreBottomController with ChangeNotifier {
  var _authenticate = false;
  get authenticate => _authenticate;

  handleDispose() {
    _authenticate = false;
    notifyListeners();
  }

  void initFetchData(context) async {
    handleDispose();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    var auth = await pref.getBool('authenticated');
    var verifyAuth = await pref.getBool('verifyAuthentication');
    if ((auth != null && auth) || (verifyAuth != null && verifyAuth)) {
      _authenticate = true;
      notifyListeners();
    }
  }
}
