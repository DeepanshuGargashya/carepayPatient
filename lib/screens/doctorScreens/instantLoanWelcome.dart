import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/doctorMobileVerification.dart';
import 'package:CarePay/view_model/doctorFlow/doctorMobileVerificationController.dart';
import 'package:CarePay/view_model/doctorFlow/instantLoanWelcomeController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:CarePay/res/textConstant.dart';

class InstantLoanWelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InstantLoanWelcomeState();
  }
}

class InstantLoanWelcomeState extends State<InstantLoanWelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<InstantLoanWelcomeController>(context, listen: false);
      fetchData.handleSplashes();
    });

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

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<InstantLoanWelcomeController>(context);
    final mobileVerifyController =
        Provider.of<DoctorMobileVerificationController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;

    return SafeArea(
        child: Scaffold(
            // appBar: AppBar(
            //   title: SizedBox(
            //     width: 143*fem,
            //     height: 61*fem,
            //     child: Image.asset('assets/images/carePayLogo.png'),
            //   ),
            //   centerTitle: true,
            //   automaticallyImplyLeading: false,
            //   backgroundColor: AppColors.whiteColor,
            //   elevation: 0,
            // ),
            // resizeToAvoidBottomInset: false,
            backgroundColor: AppColors.white,
            body: Padding(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    // color: Colors.red,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: Container(
                              width: 155 * fem,
                              height: 70 * fem,
                              // group167cge (455:270)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 15 * fem, 0 * fem, 10 * fem),
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 15 * fem, 0 * fem, 0 * fem),
                              // width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child:
                                  Image.asset('assets/images/carePayLogo.png'),
                            ),
                          ),
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.3,
                                // group167cge (455:270)
                                padding: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Image.asset(
                                    'assets/images/icInstantLoan.png'
                                    // : 'assets/images/icRetention.png'
                                    )),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  // group167cge (455:270)
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 5 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      additionalOffset: space,
                                      child: Text(
                                        // screen == 1
                                        TextConstant.instant,
                                        // : TextConstant.increased,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            height: 1.2 * fem,
                                            color: AppColors.primaryPurple,
                                            fontSize: 32 * fem,
                                            fontWeight: FontWeight.w700),
                                      ))),
                              Container(
                                  // group167cge (455:270)
                                  padding: EdgeInsets.fromLTRB(
                                      30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                  margin: EdgeInsets.fromLTRB(
                                      20 * fem, 5 * fem, 20 * fem, 5 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      additionalOffset: space,
                                      child: Text(
                                        // screen == 1
                                        TextConstant.enablee,
                                        // : TextConstant.enableYour,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: Colors.black,
                                            height: 1.26 * fem,
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w500),
                                      ))),
                            ],
                          ),
                          // FadeSlideTransition(
                          //   animation: _formElementAnimation,
                          //   additionalOffset: space,
                          //   child: Container(
                          //       height: MediaQuery.of(context).size.height/2.1,
                          //       // group167cge (455:270)
                          //       padding: EdgeInsets.fromLTRB(
                          //           0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          //       margin: EdgeInsets.fromLTRB(
                          //           0 * fem, 0 * fem, 0 * fem, 10 * fem),
                          //       width: double.infinity,
                          //       decoration: BoxDecoration(
                          //         borderRadius: BorderRadius.circular(12 * fem),
                          //       ),
                          //       child:
                          //           Image.asset("assets/images/icInstantLoan.png")),
                          // ),
                          // Column(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: [
                          //     Container(
                          //         // group167cge (455:270)
                          //         padding: EdgeInsets.fromLTRB(
                          //             0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          //         margin: EdgeInsets.fromLTRB(
                          //             0 * fem, 5 * fem, 0 * fem, 5 * fem),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(12 * fem),
                          //         ),
                          //         child: FadeSlideTransition(
                          //             animation: _formElementAnimation,
                          //             additionalOffset: space,
                          //             child: Text(
                          //               TextConstant.instant,
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   fontFamily: 'DM Sans',
                          //                   height: 1.2 * fem,
                          //                   color: AppColors.primaryPurple,
                          //                   fontSize: 32 * fem,
                          //                   fontWeight: FontWeight.w700),
                          //             ))),
                          //     Container(
                          //         // group167cge (455:270)
                          //         padding: EdgeInsets.fromLTRB(
                          //             30 * fem, 0 * fem, 30 * fem, 0 * fem),
                          //         margin: EdgeInsets.fromLTRB(
                          //             20 * fem, 5 * fem, 20 * fem, 5 * fem),
                          //         width: double.infinity,
                          //         decoration: BoxDecoration(
                          //           borderRadius: BorderRadius.circular(12 * fem),
                          //         ),
                          //         child: FadeSlideTransition(
                          //             animation: _formElementAnimation,
                          //             additionalOffset: space,
                          //             child: Text(
                          //               TextConstant.enableYour,
                          //               textAlign: TextAlign.center,
                          //               style: TextStyle(
                          //                   fontFamily: 'DM Sans',
                          //                   color: Colors.black,
                          //                   height: 1.26 * fem,
                          //                   fontSize: 14 * fem,
                          //                   fontWeight: FontWeight.w400),
                          //             ))),
                          //   ],
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  MirrorAnimationBuilder<double>(
                                    tween: Tween(
                                        begin: 0,
                                        end:
                                            5), // value for offset x-coordinate
                                    duration: const Duration(seconds: 1),
                                    curve: Curves
                                        .easeInOutSine, // non-linear animation
                                    builder: (context, value, child) {
                                      return Transform.translate(
                                        offset: Offset(0,
                                            value), // use animated value for x-coordinate
                                        child: child,
                                      );
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isDismissible: false,
                                            enableDrag: false,
                                            isScrollControlled: true,
                                            // barrierColor: none,
                                            // backgroundColor: Colors.green[200],
                                            backgroundColor: Colors.white,
                                            elevation: 10,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20)),
                                            ),
                                            builder: (BuildContext context) {
                                              return StatefulBuilder(builder:
                                                  (BuildContext context,
                                                      StateSetter setState) {
                                                return SizedBox(
                                                  height: mobileVerifyController
                                                          .verifyOtp
                                                      ? (MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.45 +
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets
                                                                  .bottom) *
                                                          fem
                                                      : (MediaQuery.of(context)
                                                                      .size
                                                                      .height *
                                                                  0.35 +
                                                              MediaQuery.of(
                                                                      context)
                                                                  .viewInsets
                                                                  .bottom) *
                                                          fem,
                                                  // controller.bottomSheetHeight *
                                                  //     fem,
                                                  child: Focus(
                                                    child:
                                                        DoctorMobileVerificationScreen(),
                                                    // onFocusChange: (value) {
                                                    //   print(value);
                                                    //   if (value) {
                                                    //     controller
                                                    //         .handleBottomSheet(
                                                    //             MediaQuery.of(
                                                    //                         context)
                                                    //                     .size
                                                    //                     .height /
                                                    //                 1.6);
                                                    //   } else {
                                                    //     print(mobileVerifyController
                                                    //         .verifyOtp);
                                                    //     if (mobileVerifyController
                                                    //         .verifyOtp) {
                                                    //       controller
                                                    //           .handleBottomSheet(
                                                    //               400.0);
                                                    //     } else {
                                                    //       controller
                                                    //           .handleBottomSheet(
                                                    //               300.0);
                                                    //     }
                                                    //   }
                                                    // },
                                                  ),
                                                );
                                              });
                                            });
                                      },
                                      child: FadeSlideTransition(
                                        animation: _formElementAnimation,
                                        additionalOffset: space,
                                        child: Container(
                                            // group167cge (455:270)
                                            padding: EdgeInsets.fromLTRB(
                                                5 * fem,
                                                10 * fem,
                                                5 * fem,
                                                10 * fem),
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                40 * fem, 0 * fem, 10 * fem),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.6,
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.white,
                                                  blurRadius: 5,
                                                  offset: Offset(-5, 0),
                                                ),
                                              ],
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomLeft,
                                                  colors: [
                                                    AppColors.ECEBFF,
                                                    AppColors.DAD9E7,
                                                  ]),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5 * fem),
                                            ),
                                            child: Text(
                                              TextConstant.getStarted,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  color:
                                                      AppColors.primaryPurple,
                                                  fontSize: 16 * fem,
                                                  fontWeight: FontWeight.w700),
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 15 * fem,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3.8,
                                    height: 1 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(500),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
