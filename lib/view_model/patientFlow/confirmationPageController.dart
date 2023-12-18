import 'package:CarePay/respository/doctorResp/homeMainRepository.dart';
import 'package:CarePay/screens/patientScreens/mobileVerification.dart';
import 'package:CarePay/screens/patientScreens/scannerWithScanWindow.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmationController with ChangeNotifier {
  handleProceed(context, doctorDetails, doctorId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(
        'doctorClinicName', doctorDetails['clinic'].toString());
    await pref.setString('doctorId', doctorId.toString());
    await pref.setString('role', 'patient');
    await pref.setString('doctorName', doctorDetails['name'].toString());

    Navigator.push(
      context,
      PageTransition(
          type: PageTransitionType.rightToLeftWithFade,
          child: MobileVerificationScreen()),
    );
  }
}
