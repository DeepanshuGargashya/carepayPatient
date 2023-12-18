import 'dart:async';
import 'dart:io';

import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/doctorResp/homeMainRepository.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeMainController with ChangeNotifier {
  final _myRepo = HomeMainRepository();

  var _appear = true;
  get appear => _appear;

  bool _isVisible = true;
  bool get isVisible => _isVisible;

  var _response = null;
  get response => _response;

  var _transactionResponse = null;
  get transactionResponse => _transactionResponse;

  String _statusTabBar = 'disbursed';
  get statusTabBar => _statusTabBar;

  late BuildContext _context;
  get context => _context;

  String _resultTabBar = 'sum';
  get resultTabBar => _resultTabBar;

  var _graphResponse;
  get graphResponse => _graphResponse;

  var _doctorId = null;
  get doctorId => _doctorId;
  late String _clinicValue;
  String get clinicValue => _clinicValue;

  var _loanAmount;
  get loanAmount => _loanAmount;

  bool _loading = true;
  bool get loading => _loading;

  var _loanEarnings;
  get loanEarnings => _loanEarnings;

  var _name = "";
  get name => _name;

  var clinicsName = [];
  // get clinicsName => _clinicsName.toList();

  disposeClinicName() {
    clinicsName = [];
    _name = '';
    notifyListeners();
  }

  setStatusTabBar(value) async {
    // Loader().fetchData(context);
    _statusTabBar = value.toString();

    notifyListeners();
    setResultTabBar("sum");
    // Loader().loaderClose(context);
  }

  setResultTabBar(value) async {
    Loader().fetchData(context);
    _resultTabBar = value.toString();
    notifyListeners();
    await fetchGraph();
    print("succes get");
    Loader().loaderClose(context);
  }

  fetchGraph() async {
    var res = await _myRepo.getGraphApi(
        doctorId, statusTabBar.toString(), resultTabBar.toString());

    print('graphdata');
    print(res['data']);
    print(res['data'].length);
    print(res);
    if (res['status'] == 200) {
      if (res['data'] != null && res['data'].length > 0) {
        _graphResponse = res['data'];
      }
    }
    notifyListeners();
  }

  void initFetchData(context) async {
    Loader().fetchData(context);
    _isVisible = true;
    _name = "";
    notifyListeners();
    clinicsName = [];

    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    await pref.setBool('verifyAuthentication', true);
    _doctorId = getDoctorId;
    print("tab bars");
    print(statusTabBar);
    print(resultTabBar);

    var res = await _myRepo.getDoctorDetailApi(getDoctorId.toString());
    print("get doctor detail get success");
    var loanSummaryResponse =
        await _myRepo.getDoctorLoanSummaryApi(getDoctorId.toString());
    print("get loan summary");
    _loanEarnings = loanSummaryResponse['data']['disbursed_amount'] != null
        ? loanSummaryResponse['data']['disbursed_amount']
        : 0;
    print(loanEarnings.toString());
    _loanAmount = loanSummaryResponse['data']['count'];
    print(loanAmount);
    clinicsName =
        [...clinicsName, res['data']['clinic'].toString()].toSet().toList();
    notifyListeners();
    _response = res['data'];
    print("set response res of data");

    await pref.setString('clinicName', res['data']['clinic'].toString());
    print(res['data']);
    _loading = false;
    notifyListeners();
    Loader().loaderClose(context);
    await setStatusTabBar('disbursed');
    await getThreeTransactions("");
    setClinicValue(res['data']['clinic'].toString());
    Timer(Duration(seconds: 3), () {
      _isVisible = false;
      notifyListeners();
    });
    await getDoctorDetails();
    notifyListeners();
  }

  getDoctorDetails() async {
    print("doctor detail name");
    print(name);
    var resp = await _myRepo.getDoctorDetailApi(doctorId.toString());
    print(resp);
    _name = "";
    notifyListeners();

    var tempName = resp['data']['name'].toString().split(" ");
    print('hiiiii');
    print(tempName);
    print(tempName.length);
    print(tempName[0][0]);
    for (int i = 0; i < (tempName.length > 2 ? 2 : tempName.length); i++) {
      print(tempName[i].toString());
      if (tempName[i].toString() != "" && tempName[i].isNotEmpty) {
        print("inside not null");
        _name = name + tempName[i][0];
        print(name.toString());
        notifyListeners();
      }
    }
    print("after for loop");
    print(name.toString());
  }

  setClinicValue(value) {
    print(value);
    if (value != null && value != "null") {
      _clinicValue = value.toString();
      notifyListeners();
    }
  }

  getThreeTransactions(status) async {
    Loader().fetchData(context);
    var res = await _myRepo.getAllTransactionApi(
        doctorId.toString(), status.toString());

    if (res['status'] == 200) {
      _transactionResponse = res['data'];
      print(transactionResponse.length);
      notifyListeners();
    }
    Loader().loaderClose(context);
  }

  handleLogout(context) async {
    Loader().fetchData(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('splashComplete', true);

    Loader().loaderClose(context);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade, child: HomeScreen()),
        (Route<dynamic> route) => false);
  }

  handleShareButton() async {
    // Loader().fetchData(context);
    // var url = Uri.parse(this.response['qr_url']);
    // http.Response response = await http.get(url);
    // final directory = await getTemporaryDirectory();
    // final path = directory.path;
    // final file = File('$path/image.png');
    // file.writeAsBytes(response.bodyBytes);
    // Loader().loaderClose(context);
    // Share.shareFiles(['$path/image.png']);
    Share.share('${this.response['qr_url'].toString()}', subject: "QR Code");
  }
}
