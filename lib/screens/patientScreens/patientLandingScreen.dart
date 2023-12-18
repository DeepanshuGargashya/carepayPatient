import 'package:CarePay/screens/homeScreen.dart';
import 'package:CarePay/screens/patientScreens/landingScreen.dart';
import 'package:CarePay/screens/patientScreens/mobileVerification.dart';
import 'package:CarePay/screens/patientScreens/scannerWithScanWindow.dart';
import 'package:CarePay/screens/patientScreens/shareDoctorDetails.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:CarePay/components/homeScreen/preBottom.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:permission_handler/permission_handler.dart';

class PatientLandingScreen extends StatefulWidget {
  const PatientLandingScreen({Key? key}) : super(key: key);

  @override
  State<PatientLandingScreen> createState() => _PatientLandingScreenState();
}

class _PatientLandingScreenState extends State<PatientLandingScreen> {
  Future _qrScanner() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      // String? qrdata = await scanner.scan();
      // print(qrdata);
    } else {
      var isGrant = await Permission.camera.request();

      if (isGrant.isGranted) {
        // String? qrData = await scanner.scan();
        // print(qrData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child: HomeScreen()),
        );
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.white,
              body: Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        // SizedBox(
                        //   width: 1,
                        //   height: barHeight / 3,
                        // ),
                        Container(
                            // group167cge (455:270)
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 0 * fem, 10 * fem, 0 * fem),
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12 * fem),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/images/carePayLogo.png',
                                  width: 143 * fem,
                                  height: 61 * fem,
                                )
                              ],
                            )),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.86,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Text(
                                  TextConstant.dontPostpone,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.primaryPurple,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40 * fem),
                                ),
                              ),
                            ),
                            // SizedBox(height: 15),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(10, 0, 100, 10),
                              child: Container(
                                  child: Text(TextConstant.getAn,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color: AppColors.black,
                                          fontSize: 16 * fem,
                                          fontWeight: FontWeight.w500))),
                            ),
                            SizedBox(height: 15),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.ECEBFF,
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                                  child: Text(TextConstant.instantCredit,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryPurple))),
                            ),
                            // SizedBox(height:10),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.tertiaryOrange,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      padding: EdgeInsets.fromLTRB(
                                          0 * fem, 15 * fem, 0 * fem, 15 * fem),
                                      child: Text(TextConstant.interest,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.FFCF6A37))),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.tertiaryGreen,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      padding: EdgeInsets.fromLTRB(
                                          0 * fem, 15 * fem, 0 * fem, 15 * fem),
                                      child: Text(TextConstant.emiss,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.primaryGreen))),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.tertiaryOrange,
                                      borderRadius: BorderRadius.circular(6)),
                                  padding: EdgeInsets.fromLTRB(
                                      10 * fem, 15, 10 * fem, 15),
                                  child: Text(TextConstant.availLoan,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.primaryPurple))),
                            ),
                            // SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 0, right: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15 * fem, 0, 15 * fem),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 16,
                                                    width: 16,
                                                    // padding: EdgeInsets.only(top: 25),
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/images/square.png')),
                                                  ),
                                                  SizedBox(width: 4),
                                                  Text(
                                                    TextConstant.scan,
                                                    style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 14 * fem),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              // Navigator.push(
                                              //   context,
                                              //   PageTransition(
                                              //       type: PageTransitionType
                                              //           .rightToLeftWithFade,
                                              //       child:
                                              //           MobileVerificationScreen()),
                                              // );
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade,
                                                    child:
                                                        BarcodeScannerWithScanWindow()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.primaryPurple,

                                                // fixedSize: Size(380, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4 * fem)))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(TextConstant.ifYour,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12 * fem)),
                            ),
                            SizedBox(height: 10 * fem),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 0, right: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15 * fem, 0, 15 * fem),
                                              child: Text(
                                                TextConstant.shareDetails,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryPurple,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14 * fem),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .rightToLeftWithFade,
                                                    child:
                                                        ShareDoctorDetails()),
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: AppColors.ECEBFF,
                                                elevation: 0,
                                                // fixedSize: Size(380, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4 * fem)))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            width: 2,
                                            color: AppColors.black
                                                .withOpacity(0.2)))),
                              ),
                            ),
                            SizedBox(height: 100 * fem),
                            PreBottomWidget(showFaq: true),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ))),
    );
  }
}
