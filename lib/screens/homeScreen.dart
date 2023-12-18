import 'package:CarePay/res/color.dart';
// import 'package:CarePay/screens/patientScreens/congratulation.dart';
import 'package:CarePay/screens/patientScreens/dashboard.dart';
import 'package:CarePay/screens/patientScreens/landingScreen.dart';
import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
// import 'package:CarePay/screens/patientScreens/redirectionToPartner.dart';
import 'package:CarePay/screens/welcome.dart';
import 'package:CarePay/view_model/doctorFlow/instantLoanWelcomeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<InstantLoanWelcomeController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    var barHeight = Get.statusBarHeight;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(25 * fem, 0 * fem, 25 * fem, 0 * fem),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1,
                      height: barHeight,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            TextConstant.welcomeTo,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w500,
                                fontSize: 32 * fem,
                                color: AppColors.primaryPurple),
                          ),
                          SizedBox(
                            width: 1,
                            height: 8 * fem,
                          ),
                          SizedBox(
                            width: 143 * fem,
                            height: 61 * fem,
                            child: Image.asset('assets/images/carePayLogo.png'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 0 * fem, 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                        child: Text(
                          TextConstant.youSeem,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              height: 1.2 * fem,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 14 * fem),
                        )),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 0 * fem, 10 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                        child: Text(
                          TextConstant.iAm,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 24 * fem,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10.0 * fem)),
                            padding: EdgeInsets.fromLTRB(
                                15 * fem, 18 * fem, 15 * fem, 18 * fem),
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            backgroundColor: AppColors.ECEBFF),
                        onPressed: () {
                          controller.handleHomeNavigation(context);
                        },
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextConstant.doctor,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.primaryPurple,
                                    fontSize: 32 * fem,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 1,
                                height: 10 * fem,
                              ),
                              Text(
                                TextConstant.iWant,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black3,
                                    height: 1.25 * fem,
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                      width: 1,
                      height: 13 * fem,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10.0 * fem)),
                            padding: EdgeInsets.fromLTRB(
                                15 * fem, 18 * fem, 15 * fem, 18 * fem),
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            backgroundColor: AppColors.tertiaryGreen),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   PageTransition(
                          //       type: PageTransitionType.rightToLeftWithFade,
                          //       child: RedirectionToPartner()),
                          // );
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: PatientLandingScreen()),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TextConstant.patient,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.primaryPurple,
                                    fontSize: 32 * fem,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                width: 1,
                                height: 10 * fem,
                              ),
                              Text(
                                TextConstant.availLoans,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black3,
                                    height: 1.25 * fem,
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
