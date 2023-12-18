import 'dart:convert';

import 'package:CarePay/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/loader.dart';
import '../../respository/patientResp/dashboardRepository.dart';

class DashboardController with ChangeNotifier {
  final _myRepo = DashboardRepository();

  var _userId;
  get userId => _userId;

  late BuildContext _context;
  get context => _context;

  bool _loading = true;
  get loading => _loading;

  var _userDetailResponse = null;
  get userDetailResponse => _userDetailResponse;

  var _loanDetailResponse = null;
  get loanDetailResponse => _loanDetailResponse;

  var _loanEmi = 0;
  get loanEmi => _loanEmi;

  var _paidCount = 1;
  get paidCount => _paidCount;

  var _firstUnpaidData = null;
  get firstUnpaidData => _firstUnpaidData;

  void initFetchData(context) async {
    _loading = true;
    notifyListeners();
    Loader().fetchData(context);
    // clinicsName = [""];

    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId').toString();
    // var userId = 'ywO7ZkVZxNThaIENT7FsP2tcFMOO7qTg';
    notifyListeners();

    await pref.setBool('verifyAuthentication', true);
    // _doctorId = getDoctorId;
    // print("tab bars");
    // print(statusTabBar);
    // print(resultTabBar);

    var res = await _myRepo.getUserDetailApi(userId.toString());
    print("user detail response");
    print(res);
    if (res['status'] == 200) {
      _userDetailResponse = res['data'];
      notifyListeners();
    }
    var response = await _myRepo.getInitiateFlowApi(userId.toString());

    var getEncodeResponse = jsonEncode(response);
    response = jsonDecode(getEncodeResponse);
    print("loan details get response");
    print(response);

    if (response['status'] == 200) {
      _loanDetailResponse = response['data'][0];
      _loanEmi = response['data'][0]['loan_type'].toString() == "E6" ? 6 : 3;

      print("all good before loop");
      for (var item in response['data'][0]['emi_details']) {
        if (item['status'] == "PAID") {
          _paidCount = paidCount + 1;
          notifyListeners();
        } else if (item['status'] == "UNPAID") {
          _firstUnpaidData = item;
          notifyListeners();
          break;
        }
      }

      // for (var index = 0;
      //     index < response['data']['emi_details'].length;
      //     index++) {
      //   if (response['data']['emi_details'][index]['status'] == "PAID") {
      //     _paidCount = paidCount + 1;
      //     notifyListeners();
      //   } else if (response['data']['emi_details'][index]['status'] ==
      //       "UNPAID") {
      //     _firstUnpaidData = response['data']['emi_details'][index];
      //     notifyListeners();
      //     break;
      //   }
      // }
    }

    _loading = false;
    notifyListeners();
    Loader().loaderClose(context);
  }

  handleLogout(context) async {
    Loader().fetchData(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Loader().loaderClose(context);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: HomeScreen()),
        (Route<dynamic> route) => false);
  }
}
