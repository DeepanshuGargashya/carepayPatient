import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/doctorResp/allTransactionRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllTransactionController with ChangeNotifier {
  final _myRepo = AllTransactionRepository();

  var _response = [];
  get response => _response;
  bool _isListEnd = false;
  bool get isListEnd => _isListEnd;
  var _fetchPage = 1;
  get fetchPage => _fetchPage;
  late BuildContext _context;
  get context => _context;

  var _doctorId = null;
  get doctorId => _doctorId;

  var _allLoanCount = 0;
  get allLoanCount => _allLoanCount;
  var _disbursedCount = 0;
  get disbursedCount => _disbursedCount;
  var _approvedCount = 0;
  get approvedCount => _approvedCount;

  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print("islistend true");
    print(isListEnd);

    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;

    _allLoanCount =
        await _myRepo.getAllTransactionCountApi(getDoctorId.toString(), "");
    _disbursedCount = await _myRepo.getAllTransactionCountApi(
        getDoctorId.toString(), "disbursed");
    _approvedCount = await _myRepo.getAllTransactionCountApi(
        getDoctorId.toString(), "approved");
    fetchLoans(status: "", countOf: "allLoans", reset: true);
    // print(res['data']);

    notifyListeners();
    Loader().loaderClose(context);
  }

  fetchLoans({required status, required countOf, required reset}) async {
    Loader().fetchData(context);
    print(status);
    print(countOf);
    print(reset);
    if (reset) {
      _fetchPage = 1;
      _isListEnd = false;
      _response = [];
      notifyListeners();
    }
    var count;
    var res = await _myRepo.getAllTransactionApi(
        doctorId.toString(), fetchPage, status.toString());
    _response = [...response, ...res['data']];
    if (countOf == "allLoans") {
      count = allLoanCount;
    } else if (countOf == "disbursed") {
      count = disbursedCount;
    } else if (countOf == "approved") {
      count = approvedCount;
    } else {
      return;
    }

    if (count <= response.length && count != null) {
      _isListEnd = true;
    } else {
      _isListEnd = false;
      _fetchPage = fetchPage + 1;
    }
    notifyListeners();
    Loader().loaderClose(context);
  }
}
