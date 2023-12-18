import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';

class LandingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LandingState();
  }
}

class LandingState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final _formKeyMob = GlobalKey<FormState>();

  final mobController = TextEditingController();
  @override
  void initState() {
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

  // state variables
  int screen = 1;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    var barHeight = Get.statusBarHeight;
    // TODO: implement build
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: 1,
                    height: barHeight / 3,
                  ),
                  Container(
                      // group167cge (455:270)
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 0 * fem, 10 * fem, 0 * fem),
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 10 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12 * fem),
                      ),
                      child: FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image.asset(
                                'assets/images/carePayLogo.png',
                                width: 143 * fem,
                                height: 61 * fem,
                              )
                            ],
                          ))),
                ],
              ),
              Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height / (0.9 * fem),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        10 * fem, 0 * fem, 10 * fem, 0 * fem),
                    child: SingleChildScrollView(
                        child: Column(children: [
                      Container(

                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: space,
                              child: Column(
                                children: [
                                  Text(
                                    TextConstant.postpone,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.primaryPurple,
                                        fontSize: 40 * fem,
                                        height: 0.9 * fem,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 10 * fem,
                                  ),
                                  Text(
                                    TextConstant.instantMedical,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.black,
                                        fontSize: 16 * fem,
                                        // height: 0.9 * fem,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ))),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      Container(
                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: space,
                              child: SizedBox(
                                width: double.infinity,
                                child: Image.asset(
                                    'assets/images/landingScreenLogo.png'),
                              ))),
                      Container(
                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: space,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 15 * fem, 10 * fem, 15 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.ECEBFF,
                                        // border: Border(
                                        //     left:
                                        //         BorderSide(color: HexColor('#514C9F'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 16 * fem,
                                          height: 16 * fem,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryPurple,
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                        SizedBox(
                                          width: 5 * fem,
                                          height: 1,
                                        ),
                                        Text(
                                          TextConstant.instantCredit,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16 * fem,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryPurple),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 15 * fem, 10 * fem, 15 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.primaryOrange
                                            .withOpacity(0.2),
                                        // border: Border(
                                        //     left:
                                        //         BorderSide(color: HexColor('#514C9F'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 16 * fem,
                                          height: 16 * fem,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryOrange,
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                        SizedBox(
                                          width: 5 * fem,
                                          height: 1,
                                        ),
                                        Text(
                                          TextConstant.instantCredit,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16 * fem,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryPurple),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 10 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 15 * fem, 10 * fem, 15 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: AppColors.tertiaryGreen,
                                        // border: Border(
                                        //     left:
                                        //         BorderSide(color: HexColor('#514C9F'))),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0))),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 16 * fem,
                                          height: 16 * fem,
                                          decoration: BoxDecoration(
                                              color: AppColors.primaryGreen,
                                              borderRadius:
                                                  BorderRadius.circular(2)),
                                        ),
                                        SizedBox(
                                          width: 5 * fem,
                                          height: 1,
                                        ),
                                        Text(
                                          TextConstant.instantCredit,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16 * fem,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryPurple),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 10 * fem,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.fromLTRB(
                                                    8 * fem,
                                                    15 * fem,
                                                    8 * fem,
                                                    15 * fem),
                                                primary: AppColors.transparent,
                                                onSurface:
                                                    AppColors.transparent,
                                                shadowColor:
                                                    AppColors.transparent,
                                                backgroundColor:
                                                    AppColors.primaryPurple),
                                            onPressed: () {
                                              setState(() {
                                                Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeftWithFade,
                                                      child:
                                                          PatientLandingScreen()),
                                                );
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  TextConstant.checkEligibility,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    // 'Work Sans',
                                                    fontSize: 14 * fem,
                                                    fontWeight: FontWeight.w700,
                                                    height: 1.1725 * fem / fem,
                                                    color: Color(0xffffffff),
                                                    letterSpacing: 0.5,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                    ],
                                  ),
                                ],
                              ))),
                    ]))),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
