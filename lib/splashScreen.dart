import 'dart:io';
import 'dart:typed_data';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/bottom_bar.dart';
import 'package:CarePay/screens/doctorScreens/home.dart';
import 'package:CarePay/screens/doctorScreens/instantLoanWelcome.dart';
import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/screens/patientScreens/dashboard.dart';
import 'package:CarePay/screens/patientScreens/mobileVerification.dart';
import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
import 'package:CarePay/view_model/doctorFlow/doctorMobileVerificationController.dart';
import 'package:CarePay/view_model/patientFlow/mobileVerificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// this is being used for load all library to reduce app start time
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    final h = MediaQuery.of(context).size.height;
    print("Heelo");
    return Container(
      color: AppColors.primaryPurple,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/splashCarePayLogo.png',
            height: 50 * fem,
          ),
          SizedBox(
            width: 1,
            height: 30 * fem,
          ),
          FadeSlideTransition(
            animation: _formElementAnimation,
            additionalOffset: space,
            child: Text(
              "Don’t delay, just CarePay",
              style: TextStyle(
                  decoration: TextDecoration.none,
                  color: AppColors.white,
                  fontSize: 24 * fem,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'DM Sans'),
            ),
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    _initAsync();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    final fadeSlideTween = Tween<double>(begin: 0.0, end: 1.0);

    _formElementAnimation = fadeSlideTween.animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(
        0.4,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));
    _animationController.forward();
    super.initState();
  }

  /// load all library here
  void _initAsync() async {
    WidgetsFlutterBinding.ensureInitialized();

    final SharedPreferences pref = await SharedPreferences.getInstance();
    // print(panCardUploadName.toString().length);
    dynamic authentication = false;
    dynamic verifyAuthentication = false;
    dynamic role;
    dynamic navTo = HomeScreen();

    try {
      var auth = await pref.getBool('authenticated');
      var verifyAuth = await pref.getBool('verifyAuthentication');
      var doctorId = await pref.getString('doctorId');
      var role = await pref.getString('role');
      authentication = auth != null ? auth : false;
      verifyAuthentication = verifyAuth != null ? verifyAuth : false;
      print(doctorId.toString().length);
      print(doctorId);
      // if (authentication || verifyAuthentication) {
      //   role = pref.getString('role');
      // }
      if (role == null) {
        // homescreen
        navTo = HomeScreen();
      }
      // <------------ patient navigation --------------->
      else if (role.toString() == 'patient') {
        if (doctorId.toString().length > 5 && verifyAuthentication) {
          // navigate to dashboard
          navTo = DashboardScreen();
        } else if (doctorId.toString().length > 5 && authentication) {
          // fetch form status api
          var res = await MobileVerificationController().fetchFormStatus();
          navTo = res;
        } else if (doctorId.toString().length > 5) {
          // mobileVerification
          navTo = MobileVerificationScreen();
        } else {
          // patientLandingScreen
          navTo = PatientLandingScreen();
        }
      }
      // <------------ doctor navigation --------------->
      else if (role.toString() == 'doctor') {
        if (verifyAuthentication) {
          // value bottom bar
          navTo = bottomBar();
        } else if (authentication) {
          navTo = home();
          // value home
        } else if (doctorId.toString().length > 5) {
          // fetch form status api
          var res =
              await DoctorMobileVerificationController().fetchFormStatus();
          navTo = res;
        } else {
          navTo = InstantLoanWelcomeScreen();
        }
      }
    } catch (e) {
      print(e);
    }
    _openMyPage(navTo);
    // else if (Settings.isInitialized) {
    //   _openMyPage(SplashScreen());
    // } else {
    //   _openMyPage(SplashScreen());
    // }

    // Get.offAndToNamed(path);
  }

  // Future _cachingPictures() {
  //   return Future.wait([
  //     'assets/images/splash_building.svg',
  //     'assets/images/onboarding1.svg',
  //     'assets/images/onboarding2.svg',
  //     'assets/images/onboarding3.svg',
  //     'assets/images/onboarding4.svg',
  //     'assets/images/pay-page.svg'
  //   ].map((file) {
  //     return precachePicture(
  //         ExactAssetPicture(SvgPicture.svgStringDecoderBuilder, file), null);
  //   }));
  // }
  void _openMyPage(Widget screen) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => screen,
        ),
        (Route<dynamic> route) => false);
  }
}
