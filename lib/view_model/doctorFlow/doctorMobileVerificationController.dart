import 'dart:async';
import 'package:CarePay/components/loader.dart';
import 'package:CarePay/respository/doctorResp/doctor_auth_repository.dart';
import 'package:CarePay/screens/doctorScreens/address.dart';
import 'package:CarePay/screens/doctorScreens/bank_details.dart';
import 'package:CarePay/screens/doctorScreens/bottom_bar.dart';
import 'package:CarePay/screens/doctorScreens/home.dart';
import 'package:CarePay/screens/doctorScreens/homeMain.dart';
import 'package:CarePay/screens/doctorScreens/instantLoanWelcome.dart';
import 'package:CarePay/screens/doctorScreens/professional.dart';
import 'package:CarePay/screens/doctorScreens/upload.dart';
import 'package:CarePay/screens/doctorScreens/welcomeScreen.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorMobileVerificationController with ChangeNotifier {
  final _myRepo = DoctorAuthRepository();
  Timer? mytimer;

  final fieldOne = TextEditingController();
  final fieldTwo = TextEditingController();
  final fieldThree = TextEditingController();
  final fieldFour = TextEditingController();
  final mobController = TextEditingController();
  int _secondsRemaining = 60;
  int get secondsRemaining => _secondsRemaining;
  bool _verifyOtp = false;
  bool get verifyOtp => _verifyOtp;

  handleClearAndReset(context) async {
    // Loader().fetchData(context);
    _secondsRemaining = 0;
    notifyListeners();
    this.mobController.clear();
    fieldOne.clear();
    fieldTwo.clear();
    fieldThree.clear();
    fieldFour.clear();
    // await Future.delayed(Duration(milliseconds: 1200));
    // Loader().loaderClose(context);
    _verifyOtp = false;
    notifyListeners();
  }

  Future<void> handleGenerateOtp(BuildContext context) async {
    Loader().fetchData(context);
    try {
      var res = await _myRepo.generateOtpApi(mobController.text.toString());

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

  Future<void> handleVerifyOtp(BuildContext context) async {
    Loader().fetchData(context);
    try {
      print("inside verify");
      var res = await _myRepo.verifyOtpApi(mobController.text.toString(),
          '${fieldOne.text.toString()}${fieldTwo.text.toString()}${fieldThree.text.toString()}${fieldFour.text.toString()}');

      print(res);
      print(res['status']);
      // print(res['user_id']);
      if (res?['status'] == 200) {
        print("login response");
        final SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('number', mobController.text.toString());
        await pref.setString('role', 'doctor');
        //   setState(() {
        // setState(() {

        // notifyListeners();

        if (res['data'].toString() == "NOT_VERIFIED") {
          print("navigate");
          // Loader().loaderClose(context);
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: DoctorWelcomeScreen()),
          );
        } else {
          var response =
              await _myRepo.getPersonalDetailApi(mobController.text.toString());
          final SharedPreferences pref = await SharedPreferences.getInstance();
          await pref.setString('doctorId', response['data']['doctorId']);
          if (res['data'].toString() == "VERIFIED") {
            Navigator.pushReplacement(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeftWithFade,
                  child: bottomBar()),
            );
          }
        }
        await handleClearAndReset(context);

        // navigate according form status

        if (res['data'].toString() == "PERSONAL") {
          print("navigate");

          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: practice()),
          );
        } else if (res['data'].toString() == "PRACTICE") {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade, child: address()),
          );
        } else if (res['data'].toString() == "ADDRESS") {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: bank_details()),
          );
        } else if (res['data'].toString() == "BANK") {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade, child: upload()),
          );
        } else if (res['data'].toString() == "DOCUMENTS") {
          Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade, child: home()),
          );
        }
      } else {
        Utils.toastMessage("Invalid OTP");
        Loader().loaderClose(context);
      }
    } catch (e) {
      Utils.toastMessage('Check Internet Connection');
      Loader().loaderClose(context);
    }
  }

  dynamic fetchFormStatus() async {
    // Loader().fetchData(context);
    var path;
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      var doctorId = await pref.getString('doctorId');
      if (doctorId != null && doctorId != '') {
        var res = await _myRepo.getFormStatusApi(doctorId.toString());
        print(res);
        if (res?['status'] == 200) {
          // Loader().loaderClose(context);
          var stage = res['data'].toString();

          switch (stage) {
            case "PERSONAL":
              path = practice();
              break;
            case "PRACTICE":
              path = address();
              break;
            case "ADDRESS":
              path = bank_details();
              break;
            case "BANK":
              path = upload();
              break;
            case "DOCUMENTS":
              path = home();
              break;
            case "VERIFIED":
              path = homeMain();
              break;
            case "NOT_VERIFIED":
              path = DoctorWelcomeScreen();
              // path = "LoanDetails";
              break;

            default:
              path = InstantLoanWelcomeScreen();
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
}
