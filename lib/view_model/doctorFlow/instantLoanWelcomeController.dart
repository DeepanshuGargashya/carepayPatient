import 'package:CarePay/screens/doctorScreens/instantLoanWelcome.dart';
import 'package:CarePay/screens/welcome.dart';
import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstantLoanWelcomeController with ChangeNotifier {
  var _bottomSheetHeight = 300;
  get bottomSheetHeight => _bottomSheetHeight;

  handleBottomSheet(double value) {
    print(value);
    _bottomSheetHeight = value.toInt();
  }

  handleSplashes() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('splashComplete', true);
  }

  handleHomeNavigation(context) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var splashComplete = await pref.getBool('splashComplete');

    if (splashComplete != null && splashComplete) {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: InstantLoanWelcomeScreen()),
      );
    } else {
      Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeftWithFade,
            child: WelcomeScreen()),
      );
    }
  }
}
