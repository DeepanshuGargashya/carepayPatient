import 'package:CarePay/components/loader.dart';
import 'package:CarePay/screens/doctorScreens/professional.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CarePay/respository/doctorResp/addressDetailRepository.dart';
import 'package:CarePay/respository/doctorResp/bankDetailsRepository.dart';
import 'package:CarePay/respository/doctorResp/personalDetailRepository.dart';
import 'package:CarePay/screens/doctorScreens/bank_details.dart';
import 'package:CarePay/screens/doctorScreens/upload.dart';
import 'package:CarePay/utils/utils.dart';

class DoctorBankDetailsController with ChangeNotifier {
  final _myRepo = DoctorBankDetailRepository();

  TextEditingController accountNumber = TextEditingController();
  TextEditingController confirmAccountNumber = TextEditingController();
  TextEditingController accountHolderName = TextEditingController();
  TextEditingController ifscCode = TextEditingController();
  TextEditingController bankName = TextEditingController();
  TextEditingController city = TextEditingController();

  var _response = null;
  get response => _response;

  bool _ifscErrorCode = false;
  bool get ifscErrorCode => _ifscErrorCode;

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  bool _confirmPasswordVisible = true;
  bool get confirmPasswordVisible => _confirmPasswordVisible;

  var _doctorId = null;
  get doctorId => _doctorId;

  late BuildContext _context;
  get context => _context;
  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic getDoctorId = pref.getString('doctorId');
    _doctorId = getDoctorId;
    var res = await _myRepo.getBankDetailApi(getDoctorId.toString());
    _response = res['data'];
    print(res['data']);

    //   setState(() {
    setController(res['data']);
    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    // print(number.toString());
    if (response != null) {
      this.accountNumber.text = response['accountNumber'] != null
          ? response['accountNumber'].toString()
          : "";
      this.confirmAccountNumber.text = response['accountNumber'] != null
          ? response['accountNumber'].toString()
          : "";
      this.accountHolderName.text = response['accountHolderName'] != null
          ? response['accountHolderName'].toString()
          : "";
      this.ifscCode.text =
          response['ifscCode'] != null ? response['ifscCode'].toString() : "";
      this.bankName.text =
          response['bankName'] != null ? response['bankName'].toString() : "";
      this.city.text = response['branchName'] != null
          ? response['branchName'].toString()
          : "";
    }
  }

  setPasswordVisible(type) {
    if (type.toString() == "pass") {
      _passwordVisible = !passwordVisible;
    } else if (type.toString() == "cpass") {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    } else {}
    notifyListeners();
  }

  fetchIFSCCodeDetail() async {
    Loader().fetchData(context);
    print("here");
    try {
      print("going to hit gardentions API");
      dynamic res =
          await _myRepo.getBankDetailsByIFSC(ifscCode.text.toString());

      if (res['branchName'] != null) {
        print("inside not null");
        print(res);

        _ifscErrorCode = false;

        this.bankName.text =
            res['branchName'] != null ? res['branchName'].toString() : "";
        this.city.text = res['city'] != null ? res['city'].toString() : "";
        notifyListeners();
        Loader().loaderClose(context);
      } else {
        this.bankName.text = "";
        this.city.text = "";

        Loader().loaderClose(context);
        print("inside null");
        Utils.toastMessage('Invalid IFSC Code');

        _ifscErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      this.bankName.text = "";
      this.city.text = "";
      Loader().loaderClose(context);
      // setState(() {
      _ifscErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
    }
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var payload;

      if (response != null) {
        payload = {
          ...response,
          "accountNumber": accountNumber.text.toString(),
          "confirmAccountNumber": confirmAccountNumber.text.toString(),
          "accountHolderName": accountHolderName.text.toString(),
          "ifscCode": ifscCode.text.toString(),
          "bankName": bankName.text.toString(),
          "branchName": city.text.toString()
        };
      } else {
        payload = {
          "doctorId": doctorId.toString(),
          "accountNumber": accountNumber.text.toString(),
          "confirmAccountNumber": confirmAccountNumber.text.toString(),
          "accountHolderName": accountHolderName.text.toString(),
          "ifscCode": ifscCode.text.toString(),
          "bankName": bankName.text.toString(),
          "branchName": city.text.toString()
        };
      }

      var res = await _myRepo.bankDetailApi(payload);
      print(res);
      if (res['status'] == 200) {
        Loader().loaderClose(context);
        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: upload()),
        );
      } else {
        Utils.toastMessage(res['data'].toString());
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage("Check Internet Connection");
      Loader().loaderClose(context);
    }
  }
}
