import 'package:CarePay/screens/patientScreens/patientLandingScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/view_model/patientFlow/mobileVerificationController.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:sms_autofill/sms_autofill.dart';

class MobileVerificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MobileVerificationState();
  }
}

class MobileVerificationState extends State<MobileVerificationScreen>
    with SingleTickerProviderStateMixin, CodeAutoFill {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final _formKeyMob = GlobalKey<FormState>();
  final _formKeyFullName = GlobalKey<FormState>();
  String codeValue = "";

  @override
  void codeUpdated() {
    print("Update code $code");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<MobileVerificationController>(context, listen: false);
      fetchData.autoFillOTP(code);
    });
    setState(() {
      print("codeUpdated");
    });
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();

  // }

  void listenOtp() async {
    print("inside listen otp");
    await SmsAutoFill().unregisterListener();
    listenForCode();
    // await Future.delayed(Duration(seconds: 5));
    await SmsAutoFill().listenForCode;
    // print(res);
    // print(res);
    print("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<MobileVerificationController>(context, listen: false);
      fetchData.handleClearAndReset(context);
    });

    super.dispose();
  }

  // final _fieldOne = TextEditingController();
  // final _fieldTwo = TextEditingController();
  // final _fieldThree = TextEditingController();
  // final _fieldFour = TextEditingController();
  // final mobController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<MobileVerificationController>(context, listen: false);
      fetchData.handleClearAndReset(context);
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
    // listenOtp();
    super.initState();
  }

  // state variables
  // bool tAc = false;
  // bool verifyOtp = false;
  // bool redirecting = false;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<MobileVerificationController>(context);
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
          if (controller.verifyOtp) {
            await controller.handleClearAndReset(context);
          } else {
            controller.logout(context);
          }
          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 1,
              centerTitle: false,
              automaticallyImplyLeading: false,
              // leadingWidth: 0,
              titleSpacing: 0,

              title: Padding(
                padding: controller.redirecting
                    ? EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 0 * fem)
                    : EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Text(
                  TextConstant.loanApplicationn,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ),

              leading: controller.redirecting
                  ? null
                  : IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () {
                        if (controller.verifyOtp)
                          [controller.handleClearAndReset(context)];
                        else
                          [
                            Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: PatientLandingScreen()),
                            )
                          ];
                      },
                    ),
            ),
            body: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 1,
                      height: barHeight / 3,
                    ),
                    // Container(
                    //     // group167cge (455:270)
                    //     padding:
                    //         EdgeInsets.fromLTRB(15 * fem, 0 * fem, 15 * fem, 0 * fem),
                    //     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(12 * fem),
                    //     ),
                    //     child: FadeSlideTransition(
                    //         animation: _formElementAnimation,
                    //         additionalOffset: space,
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Image.asset(
                    //               'assets/images/carePayLogo.png',
                    //               width: 143 * fem,
                    //               height: 61 * fem,
                    //             )
                    //           ],
                    //         ))),
                    // SizedBox(
                    //   width: 1,
                    //   height: 15 * fem,
                    // ),
                    Container(
                        height: MediaQuery.of(context).size.height / 1.165,
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                15 * fem, 0 * fem, 15 * fem, 0 * fem),
                            child: SingleChildScrollView(
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  if (!controller.redirecting) ...[
                                    if (controller.verifyOtp) ...[
                                      Container(

                                          // group167cge (455:270)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 10 * fem),
                                          width: double.infinity,
                                          // decoration: BoxDecoration(
                                          //   borderRadius: BorderRadius.circular(12 * fem),
                                          // ),
                                          child: FadeSlideTransition(
                                            animation: _formElementAnimation,
                                            additionalOffset: space,
                                            child: Text(
                                              !controller.verifyOtp
                                                  ? TextConstant
                                                      .mobileVerification
                                                  : TextConstant.enterOtp,
                                              style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 16 * fem,
                                                height: 0.9 * fem,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 1,
                                        height: 10 * fem,
                                      ),
                                      Container(
                                        // group167cge (455:270)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FadeSlideTransition(
                                              animation: _formElementAnimation,
                                              additionalOffset: 2 * space,
                                              child: Container(
                                                // emailidwU2 (455:267)
                                                margin: EdgeInsets.fromLTRB(
                                                    6 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    3 * fem),
                                                child: Text(
                                                  '${TextConstant.countryCode} ${controller.mobController.text.toString()}',
                                                  style: TextStyle(
                                                    // 'Work Sans',
                                                    fontFamily: "DM Sans",
                                                    letterSpacing: 0.5,
                                                    fontSize: 14 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.1725 * ffem / fem,
                                                    color: AppColors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // SizedBox(
                                            //   width: 1,
                                            //   height: 5 * fem,
                                            // ),
                                            FadeSlideTransition(
                                              animation: _formElementAnimation,
                                              additionalOffset: 2 * space,
                                              child: InkWell(
                                                onTap: () {
                                                  controller
                                                      .handleClearAndReset(
                                                          context);
                                                },
                                                child: Text(
                                                  TextConstant.changeNumber,
                                                  style: TextStyle(
                                                    // 'Work Sans',
                                                    decoration: TextDecoration
                                                        .underline,
                                                    fontFamily: 'DM Sans',
                                                    letterSpacing: 0.5,
                                                    fontSize: 14 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.1725 * ffem / fem,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // group6drW (154:327)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            10 * fem, 0 * fem, 10 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5 * fem),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // OtpBox(otp.length > 0 ? otp.substring(0, 1) : null, otp.length == 0),
                                            // OtpBox(otp.length > 1 ? otp.substring(1, 2) : null, otp.length == 1),
                                            // OtpBox(otp.length > 2 ? otp.substring(2, 3) : null, otp.length == 2),
                                            // OtpBox(otp.length > 3 ? otp.substring(3, 4) : null, otp.length == 3)
                                            _textFieldOTP(controller.fieldOne,
                                                first: true, last: false),
                                            SizedBox(
                                              width: 25 * fem,
                                            ),
                                            _textFieldOTP(controller.fieldTwo,
                                                first: false, last: false),
                                            SizedBox(
                                              width: 25 * fem,
                                            ),
                                            _textFieldOTP(controller.fieldThree,
                                                first: false, last: false),
                                            SizedBox(
                                              width: 25 * fem,
                                            ),
                                            _textFieldOTP(controller.fieldFour,
                                                first: false, last: true),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 1,
                                        height: 10 * fem,
                                      ),
                                      Container(
                                        // group172W14 (478:45)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 6 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        // height: double.infinity,
                                        height: 30 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // group7eNA (431:36)
                                              // margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 142.5*fem, 0*fem),
                                              height: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  if (controller
                                                          .secondsRemaining !=
                                                      0) ...[
                                                    Container(
                                                        // timeNox (431:38)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                5 * fem,
                                                                0 * fem),
                                                        width: 22 * fem,
                                                        height: 22 * fem,
                                                        child: Icon(
                                                          CupertinoIcons.timer,
                                                        )),
                                                    Text(
                                                      // 5Ca (431:37)
                                                      '${controller.secondsRemaining}',
                                                      style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        // 'Work S/ans',
                                                        fontSize: 14 * ffem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.1725 * ffem / fem,
                                                        color:
                                                            Color(0xff182d64),
                                                      ),
                                                    ),
                                                  ]
                                                ],
                                              ),
                                            ),
                                            Spacer(),
                                            TextButton(
                                              // onPressed: enableResend ? _resendCode : null,
                                              onPressed: () {
                                                if (controller
                                                        .secondsRemaining ==
                                                    0) {
                                                  listenOtp();
                                                  controller
                                                      .handleResendOtp(context);
                                                }
                                              },
                                              child: Text(
                                                TextConstant.resendOtp,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  // 'Work Sans',
                                                  fontSize: 14 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.1725 * ffem / fem,
                                                  color: controller
                                                              .secondsRemaining ==
                                                          0
                                                      ? AppColors.primaryPurple
                                                      : AppColors.grey,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ] else ...[
                                      Container(
                                        // group167cge (455:270)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            10 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FadeSlideTransition(
                                              animation: _formElementAnimation,
                                              // additionalOffset: fem,
                                              additionalOffset: 0.0,
                                              child: Container(
                                                // emailidwU2 (455:267)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    10 * fem,
                                                    0 * fem,
                                                    5 * fem),
                                                child: Text.rich(TextSpan(
                                                    children: <InlineSpan>[
                                                      TextSpan(
                                                        text: TextConstant
                                                            .fullNameAsPerPan,
                                                        style: TextStyle(
                                                          // 'Work Sans',
                                                          fontFamily: "DM Sans",
                                                          letterSpacing: 0.5,
                                                          fontSize: 14 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.1725 *
                                                              ffem /
                                                              fem,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ])),
                                              ),
                                            ),
                                            FadeSlideTransition(
                                              animation: _formElementAnimation,
                                              additionalOffset: 2 * space,
                                              child: Form(
                                                key: _formKeyFullName,
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem,
                                                      1.5 * fem),
                                                  child: TextFormField(
                                                    keyboardType:
                                                        TextInputType.name,
                                                    controller: controller
                                                        .fullNameController,
                                                    onChanged: (value) {
                                                      if (value.length > 1) {
                                                        _formKeyFullName
                                                            .currentState!
                                                            .validate();
                                                        // // _formKeyPan.currentState!.validate();
                                                      }
                                                    },
                                                    // maxLength: 10,
                                                    // autofocus: true,
                                                    style: const TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 16,
                                                        height: 1.5),
                                                    decoration: InputDecoration(
                                                      counterText: "",
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      fillColor:
                                                          AppColors.ECEBFF,
                                                      filled: true,
                                                      hintText: TextConstant
                                                          .enterName,
                                                      hintStyle: TextStyle(
                                                          // 'Work Sans',
                                                          fontFamily: "DM Sans",
                                                          fontSize: 14 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.1725 *
                                                              ffem /
                                                              fem,
                                                          color: Colors.black54,
                                                          letterSpacing: 0.5),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4 * fem),
                                                          borderSide:
                                                              BorderSide.none),
                                                    ),
                                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return TextConstant
                                                            .nameRequireddd;
                                                      } else if (value.length <
                                                          2) {
                                                        return TextConstant
                                                            .invalidName;
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10 * fem),
                                      FadeSlideTransition(
                                        animation: _formElementAnimation,
                                        additionalOffset: 2 * space,
                                        child: Container(
                                          child: Text(
                                            TextConstant.enterMobileNumberr,
                                            style: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              // letterSpacing: 0.5,
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FadeSlideTransition(
                                            animation: _formElementAnimation,
                                            additionalOffset: 2 * space,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem,
                                                  5 * fem),
                                              // padding: EdgeInsets.fromLTRB(
                                              //     0 * fem, 5 * fem, 0 * fem, 0 * fem),
                                              // color: Colors.red,
                                              child: Text(
                                                TextConstant.countryCode,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14 * fem,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          // SizedBox(height:10),
                                          Container(
                                            // group167cge (455:270)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                5 * fem, 0 * fem, 5 * fem),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      12 * fem),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: 2 * space,
                                                  child: Container(
                                                    // emailidwU2 (455:267)
                                                    margin: EdgeInsets.fromLTRB(
                                                        6 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        3 * fem),
                                                    // child: Text(
                                                    //   TextConstant.enterMobileNumber,
                                                    //   style: TextStyle(
                                                    //     // 'Work Sans',
                                                    //     fontFamily: "DM Sans",
                                                    //     // letterSpacing: 0.5,
                                                    //     fontSize: 16 * ffem,
                                                    //     fontWeight: FontWeight.w400,
                                                    //     height: 1.1725 * ffem / fem,
                                                    //     color: AppColors.black,
                                                    //   ),
                                                    // ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 1,
                                                  height: 5 * fem,
                                                ),
                                                FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: 2 * space,
                                                  child: Form(
                                                    key: _formKeyMob,
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              1.5 * fem),
                                                      child: TextFormField(
                                                        onChanged: (value) {
                                                          if (value.length >
                                                              8) {
                                                            _formKeyMob
                                                                .currentState!
                                                                .validate();
                                                            // // _formKeyPan.currentState!.validate();
                                                          }
                                                        },
                                                        controller: controller
                                                            .mobController,
                                                        maxLength: 10,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        // autofocus: true,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 16,
                                                            height: 1.5),
                                                        decoration:
                                                            InputDecoration(
                                                          counterText: "",
                                                          contentPadding:
                                                              const EdgeInsets
                                                                  .all(15),
                                                          fillColor:
                                                              AppColors.ECEBFF,
                                                          filled: true,

                                                          // isDense: true,
                                                          // floatingLabelBehavior:FloatingLabelBehavior.always,
                                                          // labelText: 'Email',
                                                          hintText: TextConstant
                                                              .enterMobileNumber,
                                                          // prefix: Text("+91"),
                                                          // prefixText: TextConstant.countryCode,
                                                          // prefixIcon: Text(
                                                          //   TextConstant.countryCode,
                                                          //   style: TextStyle(
                                                          //       fontFamily: "Dm Sans",
                                                          //       // backgroundColor: Colors.white,
                                                          //       fontSize: 16 * ffem,
                                                          //       fontWeight: FontWeight.w500,
                                                          //       height: 2.35,
                                                          //       color: Colors.black,
                                                          //       letterSpacing: 0.5),
                                                          // ),
                                                          // prefixStyle: TextStyle(
                                                          //     // 'Work Sans',
                                                          //     fontFamily: "poppins",
                                                          //     // backgroundColor: Colors.white,
                                                          //     fontSize: 16 * ffem,
                                                          //     fontWeight: FontWeight.w700,
                                                          //     height: 1.1725 * ffem / fem,
                                                          //     color: AppColors.black,
                                                          //     letterSpacing: 0.5),
                                                          hintStyle: TextStyle(
                                                              // 'Work Sans',
                                                              fontFamily:
                                                                  "DM Sans",
                                                              fontSize:
                                                                  13 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.1725 *
                                                                  ffem /
                                                                  fem,
                                                              color: AppColors
                                                                  .black54,
                                                              letterSpacing:
                                                                  0.5),
                                                          border: OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(4 *
                                                                          fem),
                                                              borderSide:
                                                                  BorderSide
                                                                      .none),
                                                          // hintText: '**********',
                                                        ),
                                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                                        validator: (value) {
                                                          if (value!
                                                              .trim()
                                                              .isEmpty) {
                                                            return TextConstant
                                                                .requiredMobile;
                                                          } else if (value
                                                                  .length <
                                                              10) {
                                                            return TextConstant
                                                                .enterValidMobileNumber;
                                                          } else if (RegExp(
                                                                  r'^[1-9]{1}[0-9]{9}$')
                                                              .hasMatch(
                                                                  value)) {
                                                            return null;
                                                          }
                                                          return TextConstant
                                                              .mobileNumberInvalid;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      FadeSlideTransition(
                                        animation: _formElementAnimation,
                                        additionalOffset: space,
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 15 * fem, 0, 10 * fem),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                child: Checkbox(
                                                    activeColor: AppColors
                                                        .primaryPurple
                                                        .withOpacity(0.1),
                                                    checkColor:
                                                        AppColors.primaryPurple,
                                                    value: controller
                                                        .isDeclareChecked,
                                                    // fillColor: MaterialStatePropertyAll(
                                                    //     AppColors.primaryPurple),
                                                    onChanged:
                                                        (bool? newValue) {
                                                      controller
                                                          .setIsDeclareChecked(
                                                              newValue);
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.3,
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      TextConstant.declare,
                                                      style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          height: 1.17 * fem,
                                                          color: controller
                                                                  .isDeclareCheckedError
                                                              ? AppColors.red
                                                              : AppColors
                                                                  .black),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      FadeSlideTransition(
                                        animation: _formElementAnimation,
                                        additionalOffset: 2 * space,
                                        child: Container(
                                          // margin: EdgeInsets.only(right: 200),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                child: Checkbox(
                                                    activeColor: AppColors
                                                        .primaryPurple
                                                        .withOpacity(0.1),
                                                    checkColor:
                                                        AppColors.primaryPurple,
                                                    value: controller.isChecked,
                                                    onChanged:
                                                        (bool? newValue) {
                                                      controller.setIsChecked(
                                                          newValue);
                                                    }),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            TextConstant.accept,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 14 * fem,
                                                            color: AppColors
                                                                .black)),
                                                    TextSpan(
                                                        text: TextConstant
                                                            .termsConditions,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 14 * fem,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: controller
                                                                    .isCheckedError
                                                                ? AppColors.red
                                                                : AppColors
                                                                    .black)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],

                                    //  xx
                                    Container(

                                        // group167cge (455:270)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            10 * fem, 0 * fem, 10 * fem),
                                        width: double.infinity,
                                        // decoration: BoxDecoration(
                                        //   borderRadius: BorderRadius.circular(12 * fem),
                                        // ),
                                        child: FadeSlideTransition(
                                            animation: _formElementAnimation,
                                            additionalOffset: space,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  0 * fem),
                                                          primary: AppColors
                                                              .transparent,
                                                          onSurface: AppColors
                                                              .transparent,
                                                          shadowColor: AppColors
                                                              .transparent,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryPurple),
                                                      onPressed: () async {
                                                        if (!controller
                                                            .verifyOtp) {
                                                          // handleGenerateOtp();

                                                          if (_formKeyMob
                                                                  .currentState!
                                                                  .validate() &&
                                                              _formKeyFullName
                                                                  .currentState!
                                                                  .validate()) {
                                                            controller
                                                                .handleGenerateOtp(
                                                                    context);
                                                            listenOtp();
                                                          } else {
                                                            _formKeyMob
                                                                .currentState!
                                                                .validate();
                                                            _formKeyFullName
                                                                .currentState!
                                                                .validate();
                                                          }
                                                        } else {
                                                          controller
                                                              .handleVerifyOtp(
                                                                  context);
                                                          // print(codeValue.toString());
                                                        }
                                                      },
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    15 * fem,
                                                                    0 * fem,
                                                                    15 * fem),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.8,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  !controller
                                                                          .verifyOtp
                                                                      ? TextConstant
                                                                          .sendOtp
                                                                      : TextConstant
                                                                          .submit,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    // 'Work Sans',
                                                                    fontSize:
                                                                        14 *
                                                                            fem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        1.1725 *
                                                                            fem /
                                                                            fem,
                                                                    color: Color(
                                                                        0xffffffff),
                                                                    letterSpacing:
                                                                        0.5,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              ],
                                            )))
                                  ] else ...[
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.4,
                                        child: FadeSlideTransition(
                                          animation: _formElementAnimation,
                                          additionalOffset: space,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 1,
                                                height: 1,
                                              ),
                                              Column(
                                                children: [
                                                  Image.asset(
                                                      'assets/images/verifiedNumberLogo.png'),
                                                  SizedBox(
                                                    width: 1,
                                                    height: 15 * fem,
                                                  ),
                                                  Text(
                                                    TextConstant.phoneVerified,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 16 * fem,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: AppColors
                                                            .primaryPurple),
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                    height: 10 * fem,
                                                  ),
                                                  Text(
                                                    TextConstant.redirecting,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 14 * fem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: AppColors.black),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15 * fem,
                                                      15 * fem,
                                                      15 * fem,
                                                      15 * fem),
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.ECEBFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4 * fem)),
                                                  child: FadeSlideTransition(
                                                      animation:
                                                          _formElementAnimation,
                                                      additionalOffset: space,
                                                      child: Text(
                                                        TextConstant.weNeed,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            color: AppColors
                                                                .primaryPurple,
                                                            fontSize: 14 * fem,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )))
                                            ],
                                          ),
                                        )),
                                  ]
                                ])))),
                  ]),
            )),
      ),
    );
  }

  Widget _textFieldOTP(TextEditingController fieldOne, {bool? first, last}) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: 54 * fem,
      height: 48 * fem,
      decoration: BoxDecoration(
        color: AppColors.ECEBFF,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.shade300.withOpacity(0.4),
        //     spreadRadius: 5,
        //     blurRadius: 10,
        //     offset: Offset(0, 3), // changes position of shadow
        //   ),
        // ],
        borderRadius: BorderRadius.circular(5 * fem),
        border: Border.all(color: AppColors.F1F1F1),
      ),
      child: Center(
        child: TextField(
          autofocus: false,
          controller: fieldOne,

          // focusNode: fieldOne == _fieldOne ? otpFirstFieldFocus :null,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            fontFamily: 'DM Sans',
          ),
          keyboardType: TextInputType.number,
          maxLength: 1,

          decoration: InputDecoration(
            hintText: "-",
            hintStyle: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 16 * ffem,
                color: AppColors.ff626),
            counter: Offstage(),
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
