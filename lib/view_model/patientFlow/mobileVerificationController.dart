import 'dart:async';

import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/screens/patientScreens/creditDetails.dart';
// import 'package:CarePay/screens/patientScreens/EMandate.dart';
// import 'package:CarePay/screens/patientScreens/addressDetail.dart';
// import 'package:CarePay/screens/patientScreens/allUnderProcessScreens/bankUnderProcess.dart';
// import 'package:CarePay/screens/patientScreens/allUnderProcessScreens/loanUnderProcess.dart';
// import 'package:CarePay/screens/patientScreens/allUnderProcessScreens/makePaymentUnderProcess.dart';
// import 'package:CarePay/screens/patientScreens/allUnderProcessScreens/underLoanProcess.dart';
// import 'package:CarePay/screens/patientScreens/bankAccountStatement.dart';
// import 'package:CarePay/screens/patientScreens/bankDetail.dart';
// import 'package:CarePay/screens/patientScreens/creditAgreement.dart';
// import 'package:CarePay/screens/patientScreens/creditDetailScreen.dart';
import 'package:CarePay/screens/patientScreens/dashboard.dart';
// import 'package:CarePay/screens/patientScreens/eMandateAfter.dart';
// import 'package:CarePay/screens/patientScreens/employmentDetails.dart';
// import 'package:CarePay/screens/patientScreens/kycVerification.dart';
import 'package:CarePay/screens/patientScreens/mobileVerification.dart';
import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../components/loader.dart';
import '../../respository/patientResp/auth_repository.dart';
// import 'package:CarePay/screens/patientScreens/personalDetail.dart';

class MobileVerificationController with ChangeNotifier {
  final _myRepo = AuthRepository();
  Timer? mytimer;

  final fieldOne = TextEditingController();
  // var get fieldOne => _fieldOne;
  final fieldTwo = TextEditingController();
  final fieldThree = TextEditingController();
  final fieldFour = TextEditingController();
  final mobController = TextEditingController();
  final fullNameController = TextEditingController();

  bool _tAc = false;
  bool get tAc => _tAc;
  bool _verifyOtp = false;
  bool get verifyOtp => _verifyOtp;
  bool _redirecting = false;
  bool get redirecting => _redirecting;

  bool _isChecked = false;
  bool get isChecked => _isChecked;

  bool _isCheckedError = false;
  bool get isCheckedError => _isCheckedError;

  bool _isDeclareChecked = false;
  bool get isDeclareChecked => _isDeclareChecked;

  bool _isDeclareCheckedError = false;
  bool get isDeclareCheckedError => _isDeclareCheckedError;

  int _secondsRemaining = 60;
  int get secondsRemaining => _secondsRemaining;

  setTermsAndCond(value) {
    _tAc = value!;
    notifyListeners();
  }

  autoFillOTP(data) {
    print(data.toString().length);
    if (data != null && data.toString().length == 4) {
      print(data.toString());
      var splitOTP = data.toString().split("");
      fieldOne.text = splitOTP[0];
      fieldTwo.text = splitOTP[1];
      fieldThree.text = splitOTP[2];
      fieldFour.text = splitOTP[3];
      print(splitOTP);
    }
  }

  setIsDeclareChecked(value) {
    _isDeclareChecked = value;
    _isDeclareCheckedError = false;
    notifyListeners();
  }

  setIsChecked(value) {
    _isChecked = value;
    _isCheckedError = false;
    notifyListeners();
  }

  void logout(context) async {
    Loader().fetchData(context);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();

    Loader().loaderClose(context);
    Navigator.pushAndRemoveUntil(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: PatientLandingScreen()),
        (Route<dynamic> route) => false);
  }

  handleClearAndReset(context) async {
    Loader().fetchData(context);
    _secondsRemaining = 0;
    notifyListeners();
    this.mobController.clear();
    fieldOne.clear();
    fieldTwo.clear();
    fieldThree.clear();
    fieldFour.clear();
    fullNameController.clear();
    setIsChecked(false);
    setIsDeclareChecked(false);
    await Future.delayed(Duration(milliseconds: 1200));
    Loader().loaderClose(context);
    _verifyOtp = false;
    notifyListeners();
  }

  Future<void> handleResendOtp(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var res = await _myRepo.resendOtpApi(mobController.text.toString());

      print(res);
      print(res['status']);
      // print(res['msg']);
      if (res?['status'] == 200) {
        print("login response");
        _secondsRemaining = 60;

        _verifyOtp = true;
        mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
          if (secondsRemaining != 0) {
            _secondsRemaining--;
            notifyListeners();
          } else {
            timer.cancel();
          }
          //code to run on every 5 seconds
        });
        notifyListeners();
      } else {
        Utils.toastMessage(res['data'].toString());
      }
    } catch (e) {
      Utils.toastMessage('Check Internet Connection');
    }
    Loader().loaderClose(context);
  }

  Future<void> handleGenerateOtp(BuildContext context) async {
    if (isChecked && isDeclareChecked) {
      Loader().fetchData(context);
      try {
        var appSignatureID = await SmsAutoFill().getAppSignature;
        var res = await _myRepo.generateOtpApi(mobController.text.toString());

        print(res);
        print(res['status']);

        if (res?['status'] == 200) {
          Loader().loaderClose(context);
          print("login response");
          _secondsRemaining = 60;

          _verifyOtp = true;
          mytimer = Timer.periodic(Duration(seconds: 1), (timer) {
            if (secondsRemaining != 0) {
              _secondsRemaining--;
              notifyListeners();
            } else {
              timer.cancel();
            }
            //code to run on every 5 seconds
          });
          notifyListeners();
        } else {
          Loader().loaderClose(context);
          Utils.toastMessage(res['data'].toString());
        }
      } catch (e) {
        Loader().loaderClose(context);
        Utils.toastMessage('Check Internet Connection');
      }
    } else {
      // Loader().loaderClose(context);
      if (!isChecked) {
        _isCheckedError = true;
      }
      if (!isDeclareChecked) {
        _isDeclareCheckedError = true;
      }
      Utils.toastMessage("Accept the Terms & conditions");
      notifyListeners();
    }
  }

  Future<void> handleVerifyOtp(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var res = await _myRepo.verifyOtpApi(mobController.text.toString(),
          '${fieldOne.text.toString()}${fieldTwo.text.toString()}${fieldThree.text.toString()}${fieldFour.text.toString()}');

      print(res);
      print(res['status']);

      if (res?['status'] == 200) {
        Loader().loaderClose(context);
        print("login response");
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('userId', res['data'].toString());
        await pref.setBool('authenticated', true);
        print("patient id");
        print(res['data'].toString());

        await pref.setString('number', mobController.text.toString());
        await pref.setString('fullNamePan', fullNameController.text.toString());
        // handleClearAndReset(context);
        _verifyOtp = false;
        _redirecting = true;
        notifyListeners();

        await new Future.delayed(const Duration(seconds: 5));

        _redirecting = false;
        notifyListeners();
        handleSplashes();
        var navTab = await fetchFormStatus();

        Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: navTab),
        );
      } else {
        Loader().loaderClose(context);
        Utils.toastMessage(res['data'].toString());
        fieldOne.clear();
        fieldTwo.clear();
        fieldThree.clear();
        fieldFour.clear();
      }
    } catch (e) {
      Loader().loaderClose(context);
      Utils.toastMessage('Check Internet Connection');
    }
  }

  dynamic fetchFormStatus() async {
    // Loader().fetchData(context);
    dynamic path = HomeScreen();
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      var userId = pref.getString('userId');
      if (userId != null && userId != '') {
        var res = await _myRepo.getFormStatusApi(userId.toString());
        print(res);
        print(res['status']);
        print(res?['status']);
        if (res?['status'] == 200) {
          print("inside status 200");
          // Loader().loaderClose(context);
          var stage = res['data'].toString();

          switch (stage) {
            case "Incomplete application":
              path = const CreditDetails();
              break;
            case "Basic":
              // path = AddressDetailScreen();
              break;
            case "Address":
              // path = EmploymentDetailScreen();
              break;
            case "Occupation":
              // path = BankDetailScreen();
              break;
            case "BankDetails":
              // path = BankAccountStatementScreen();
              break;
            case "BankStatement":
              // path = CreditDetailScreen();
              // path = "LoanDetails";
              break;
            case "LoanDetails":
              // path = KYCVerificationScreen();
              break;
            case "CREATE_CUSTOMER":
              // path = KYCVerificationScreen();
              break;
            case "KYC_INITIATED":
              // path = KYCVerificationScreen();
              break;
            case "KYC_COMPLETED":
              // path = BankUnderProcessScreen();
              break;
            case "DOCUMENT_UPLOAD":
              // path = BankUnderProcessScreen();
              break;
            case "DOCUMENT_VERIFIED":
              // path = BankUnderProcessScreen();
              break;
            case "BANK_DETAILS":
              // path = LoanUnderProcessScreen();
              break;
            case "BANK_DETAILS_VERIFIED":
              // path = CreditAgreementScreen();
              break;
            case "ESIGN_INITIATED":
              // path = CreditAgreementScreen();
              break;
            case "ESIGN_COMPLETED":
              // path = EMandateScreen();
              break;
            case "EMANDATE_INITIATED":
              // path = EMandateScreen();
              break;
            case "EMANDATE_COMPLETED":
              // path = EMandateAfter();
              break;
            case "LOAN_APPLIED":
              // path = EMandateAfter();
              // path = MakePaymentUnderProcessScreen();
              break;
            case "LOAN_APPROVED":
              // path = UnderLoanProcessScreen();
              break;
            case "DISBURSED":
              // path = UnderLoanProcessScreen();
              // path = DashboardScreen();
              break;
            case "PAID":
              // path = DashboardScreen();
              break;
            default:
              path = const CreditDetails();
          }
        } else {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.clear();
          path = HomeScreen();
          // Loader().loaderClose(context);
        }
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.clear();
        path = HomeScreen();
        // Loader().loaderClose(context);
      }
    } catch (e) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      path = HomeScreen();
      // Loader().loaderClose(context);
    }
    return path;
  }

  handleSplashes() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('splashComplete', true);
  }
}
