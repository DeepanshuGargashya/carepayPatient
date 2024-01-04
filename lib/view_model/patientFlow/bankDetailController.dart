import 'dart:async';

import 'package:CarePay/respository/patientResp/bankDetailRepository.dart';
import 'package:CarePay/respository/patientResp/rpdRepsitory.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/successfullyFetched.dart';
// import 'package:CarePay/screens/patientScreens/bankAccountStatement.dart';
// import 'package:CarePay/screens/patientScreens/bankDetail.dart';
// import 'package:CarePay/screens/patientScreens/bankDetailError.dart';
// import 'package:CarePay/screens/patientScreens/bankStatementCollection.dart';
// import 'package:CarePay/screens/patientScreens/successfullyFetched.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/loader.dart';
import '../../screens/patientScreens/tradeFareFlow/bankStatementCollection.dart';
import '../../utils/utils.dart';

class BankDetailController with ChangeNotifier {
  Timer? mytimer;
  final _myRepo = BankDetailRepository();
  final _myRpdRepo = RpdRepository();

  final bankNameController = TextEditingController();
  final branchCodeController = TextEditingController();
  final accountNumberController = TextEditingController();
  final confirmAccountNumberController = TextEditingController();
  final ifscCodeController = TextEditingController();

  var _userId;
  get userId => _userId;

  var _bankName;
  get bankName => _bankName;

  var _accountNumber;
  get accountNumber => _accountNumber;

  var _IFSCCode;
  get IFSCCode => _IFSCCode;

  var _rpdId;
  get rpdId => _rpdId;

  bool _passwordVisible = true;
  bool get passwordVisible => _passwordVisible;

  var _context;
  get context => _context;

  bool _confirmPasswordVisible = true;
  bool get confirmPasswordVisible => _confirmPasswordVisible;

  var _response = null;
  get response => _response;

  bool _ifscErrorCode = false;
  bool get ifscErrorCode => _ifscErrorCode;

  fetchIFSCCodeDetail() async {
    Loader().fetchData(context);
    print("here");
    try {
      print("going to hit gardentions API");
      dynamic res = await _myRepo
          .getPatientBankDetailsByIFSC(ifscCodeController.text.toString());

      if (res['branchName'] != null) {
        print("inside not null");
        print(res);

        _ifscErrorCode = false;
        _bankName =
            res['branchName'] != null ? res['branchName'].toString() : "";
        this.bankNameController.text =
            res['branchName'] != null ? res['branchName'].toString() : "";
        branchCodeController.text =
            res['branchCode'] != null ? res['branchCode'].toString() : "";

        notifyListeners();
        Loader().loaderClose(context);
      } else {
        this.bankNameController.text = "";
        branchCodeController.text = "";
        _bankName = "";
        Loader().loaderClose(context);
        print("inside null");
        Utils.toastMessage('Invalid IFSC Code');

        _ifscErrorCode = true;
        notifyListeners();
      }
      return true;
    } catch (e) {
      _bankName = "";
      this.bankNameController.text = "";
      branchCodeController.text = "";
      Loader().loaderClose(context);
      // setState(() {
      _ifscErrorCode = true;
      notifyListeners();
      // });
      Utils.toastMessage("Check Internet Connection");
      return true;
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

  void initFetchData(context) async {
    Loader().fetchData(context);
    _context = context;
    print('initS');
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId').toString();
    print(userId);
    var res = await _myRepo.getBankDetail(userId.toString());
    _response = res['data'];
    print(res['data']);
    setController(res['data']);
    notifyListeners();
    Loader().loaderClose(context);
  }

  setController(response) {
    print("setting controller");
    print(response);
    if (response != "") {
      this.accountNumberController.text = response['accountNumber'] != null
          ? response['accountNumber'].toString()
          : "";
      this.confirmAccountNumberController.text =
          response['accountNumber'] != null
              ? response['accountNumber'].toString()
              : "";
      this.ifscCodeController.text =
          response['ifscCode'] != null ? response['ifscCode'].toString() : "";
      this.bankNameController.text =
          response['bankName'] != null ? response['bankName'].toString() : "";
      branchCodeController.text = response['branchCode'] != null
          ? response['branchCode'].toString()
          : "";
    } else {}
  }

  handleProceedThisSubmition(BuildContext context) async {
    Loader().fetchData(context);
    final SharedPreferences pref = await SharedPreferences.getInstance();
    _userId = pref.getString('userId').toString();
    notifyListeners();
    print(userId);
    try {
      print('going to craete payload');

      var payload = {
        "userId": userId.toString(),
        "accountNumber": accountNumber.toString(),
        "confirmAccountNumber": accountNumber.toString(),
        "ifscCode": IFSCCode.toString(),
        "bankName": bankName.toString(),
        "formStatus": ""
      };

      var res = await _myRepo.handleSubmitionApi(payload);
      print(res);
      if (res['status'] == 200) {
        Loader().loaderClose(context);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: BAnkStatementCollection()));
      } else {
        Utils.toastMessage(res['data'].toString());
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage("Check Internet Connection");
      Loader().loaderClose(context);
    }
  }

  handleSubmition(BuildContext context) async {
    Loader().fetchData(context);
    try {
      print('going to craete payload');
      var payload;

      if (response != "") {
        payload = {
          ...response,
          "userId": userId.toString(),
          "accountNumber": accountNumberController.text.toString(),
          "confirmAccountNumber":
              confirmAccountNumberController.text.toString(),
          "ifscCode": ifscCodeController.text.toString(),
          "bankName": bankNameController.text.toString(),
          "formStatus": ""
        };
      } else {
        payload = {
          "userId": userId.toString(),
          "accountNumber": accountNumberController.text.toString(),
          "confirmAccountNumber":
              confirmAccountNumberController.text.toString(),
          "ifscCode": ifscCodeController.text.toString(),
          "bankName": bankNameController.text.toString(),
          "formStatus": ""
        };
      }

      var res = await _myRepo.handleSubmitionApi(payload);
      print(res);
      if (res['status'] == 200) {
        Loader().loaderClose(context);
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const SuccessfullyFetched()));
      } else {
        Utils.toastMessage(res['data'].toString());
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage("Check Internet Connection");
      Loader().loaderClose(context);
    }
  }

  getRpdDetails(context) async {
    var res = await _myRpdRepo.getRpdDetails(rpdId.toString());
    if (res['status'] == 200) {
      if (res['data']['status'] ==
          "BAV_REVERSE_PENNY_DROP_PAYMENT_SUCCESSFUL") {
        if (res['data']['data'] != null) {
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeftWithFade,
          //         child: SuccessfullyFetched()));
        } else {
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeftWithFade,
          //         child: BankDetailScreen()));
        }
      } else {
        // Navigator.pushReplacement(
        //     context,
        //     PageTransition(
        //         type: PageTransitionType.rightToLeftWithFade,
        //         child: BankDetailError()));
      }
    } else {
      Utils.toastMessage("Something went wrong");
      // Navigator.pushReplacement(
      //     context,
      //     PageTransition(
      //         type: PageTransitionType.rightToLeftWithFade,
      //         child: BankDetailError()));
    }
  }

  getRpdBankDetails(context) async {
    var res = await _myRpdRepo.getRpdDetails(rpdId.toString());
    if (res['status'] == 200) {
      if (res['data']['status'] ==
          "BAV_REVERSE_PENNY_DROP_PAYMENT_SUCCESSFUL") {
        if (res['data']['data'] != null) {
          _accountNumber = res['data']['data']['bankAccountNumber'].toString();
          _IFSCCode = res['data']['data']['bankAccountIfsc'].toString();
          this.ifscCodeController.text =
              res['data']['data']['bankAccountIfsc'].toString();
          notifyListeners();
          fetchIFSCCodeDetail();
        } else {
          // Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeftWithFade,
          //         child: BankDetailScreen()));
        }
      } else {
        Navigator.pop(context);
      }
    } else {
      Utils.toastMessage("Something went wrong");
      Navigator.pop(context);
    }
  }

  handleFetchingBankDetails(context) async {
    try {
      var res = await _myRpdRepo.createRpd();
      print(res);
      if (res['status'] == 200) {
        _rpdId = res['data']['id'];
        notifyListeners();
        Uri upi = Uri.parse(res['data']['upiLink'].toString());
        // Uri upi = Uri.parse(
        //     'upi://pay?pa=9812894230@ybl&pn=Chhavidutt%20Sharma&am=1&tr=1201604228779345406&tn=Account%20Verification&cu=INR&mode=04');
        if (await launchUrl(upi)) {
          print("done");
        } else {
          Navigator.pop(context);
          print("not done");
          //dailer is not opened
        }
      }
    } catch (e) {
      Utils.toastMessage("Did not find any UPI app");
      Navigator.pop(context);
    }
    // Navigator.pushReplacement(
    //     context,
    //     PageTransition(
    //         type: PageTransitionType.rightToLeftWithFade,
    //         child: SuccessfullyFetched()));
  }

  handleTemp(context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: const SuccessfullyFetched()));
  }

  handleSuccessfullyfetchedTemp(context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: const BAnkStatementCollection()));
  }
}
