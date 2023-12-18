import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/doctorMobileVerificationController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/textConstant.dart';

class DoctorMobileVerificationScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorMobileVerificationState();
  }
}

class DoctorMobileVerificationState
    extends State<DoctorMobileVerificationScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final _formKeyMob = GlobalKey<FormState>();

  // final _fieldOne = TextEditingController();
  // final _fieldTwo = TextEditingController();
  // final _fieldThree = TextEditingController();
  // final _fieldFour = TextEditingController();
  // final mobController = TextEditingController();
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

  @override
  void dispose() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<DoctorMobileVerificationController>(context,
          listen: false);
      fetchData.handleClearAndReset(context);
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DoctorMobileVerificationController>(context);
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
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      15 * fem, 50 * fem, 15 * fem, 0 * fem),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () async {
                                await controller.handleClearAndReset(context);
                                Navigator.pop(context);
                              },
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: Image.asset('assets/images/X.png'),
                              ),
                            ),
                          ],
                        ),
                        Container(

                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 10 * fem),
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(12 * fem),
                            // ),
                            child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: space,
                              child: Text(
                                !controller.verifyOtp
                                    ? TextConstant.logIn
                                    : TextConstant.verifyOTP,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.primaryPurple,
                                    fontSize: 24 * fem,
                                    height: 0.9 * fem,
                                    fontWeight: FontWeight.w700),
                              ),
                            )),
                        SizedBox(
                          width: 1,
                          height: 6 * fem,
                        ),

                        if (controller.verifyOtp) ...[
                          Container(

                              // group167cge (455:270)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 10 * fem),
                              width: double.infinity,
                              // decoration: BoxDecoration(
                              //   borderRadius: BorderRadius.circular(12 * fem),
                              // ),
                              child: FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: space,
                                child: Text(
                                  TextConstant.enterOtp,
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: Colors.black,
                                    fontSize: 16 * fem,
                                    height: 0.8 * fem,
                                    // fontWeight: FontWeight.w500
                                  ),
                                ),
                              )),
                          Container(
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 5 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Container(
                                    // emailidwU2 (455:267)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                    child: Text(
                                      '${TextConstant.countryCode} ${controller.mobController.text.toString()}',
                                      style: TextStyle(
                                        // 'Work Sans',
                                        fontFamily: 'DM Sans',
                                        // letterSpacing: 0.5,
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w700,
                                        height: 1.4 * fem,
                                        color: Colors.black,
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
                                      controller.handleClearAndReset(context);
                                    },
                                    child: Text(
                                      TextConstant.changeNumber,
                                      style: TextStyle(
                                        // 'Work Sans',
                                        decoration: TextDecoration.underline,
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
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 10 * fem, 0 * fem, 10 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: 7 * fem,
                          ),
                          Container(
                            // group172W14 (478:45)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 6 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            // height: double.infinity,
                            height: 30 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // group7eNA (431:36)
                                  // margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 142.5*fem, 0*fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (controller.secondsRemaining != 0) ...[
                                        Container(
                                            // timeNox (431:38)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 5 * fem, 0 * fem),
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
                                            fontWeight: FontWeight.w500,
                                            height: 1.1725 * ffem / fem,
                                            color: Color(0xff182d64),
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
                                    if (controller.secondsRemaining == 0) {
                                      controller.handleResendOtp(context);
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
                                      color: controller.secondsRemaining == 0
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
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 5 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Container(
                                    // emailidwU2 (455:267)
                                    margin: EdgeInsets.fromLTRB(
                                        6 * fem, 0 * fem, 0 * fem, 3 * fem),
                                    child: Text(
                                      TextConstant.mobileNumber,
                                      style: TextStyle(
                                        // 'Work Sans',
                                        fontFamily: "DM Sans",
                                        letterSpacing: 0.5,
                                        fontSize: 14 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.1725 * ffem / fem,
                                        color: Color(0xff000000),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                  height: 5 * fem,
                                ),
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Form(
                                    key: _formKeyMob,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller: controller.mobController,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          if (value.length > 9) {
                                            _formKeyMob.currentState!
                                                .validate();
                                          }
                                        },
                                        // autofocus: true,
                                        style: const TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 16,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,

                                          // isDense: true,
                                          // floatingLabelBehavior:FloatingLabelBehavior.always,
                                          // labelText: 'Email',
                                          hintText:
                                              TextConstant.enterMobileNumber,
                                          // prefix: Text(TextConstant.countryCode),
                                          // prefixText: TextConstant.countryCode,

                                          prefixIcon: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                5 * fem,
                                                0 * fem,
                                                5 * fem,
                                                0 * fem),
                                            child: Text(
                                              TextConstant.countryCode,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontFamily: "Dm Sans",

                                                  // backgroundColor: Colors.white,
                                                  fontSize: 16 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 2.2,
                                                  color: Colors.black,
                                                  letterSpacing: 0.5),
                                            ),
                                          ),
                                          // prefixStyle: TextStyle(
                                          //     // 'Work Sans',
                                          //     fontFamily: "Dm Sans",
                                          //     // backgroundColor: Colors.white,
                                          //     fontSize: 16 * ffem,
                                          //     fontWeight: FontWeight.w700,
                                          //     height: 1.1725 * ffem / fem,
                                          //     color: Colors.black,
                                          //     letterSpacing: 0.5),
                                          hintStyle: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "Dm Sans",
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: Colors.black54,
                                              letterSpacing: 0.5),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                          // hintText: '**********',
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.requiredMobile;
                                          } else if (value.length < 10) {
                                            return TextConstant
                                                .enterValidMobileNumber;
                                          } else if (RegExp(
                                                  r'^[1-9]{1}[0-9]{9}$')
                                              .hasMatch(value)) {
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

                        //  button
                        Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 10 * fem, 0 * fem, 10 * fem),
                            width: double.infinity,
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(12 * fem),
                            // ),
                            child: FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: space,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                              ),
                                              padding: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem),
                                              primary: Colors.transparent,
                                              onSurface: Colors.transparent,
                                              shadowColor: Colors.transparent,
                                              backgroundColor:
                                                  AppColors.primaryPurple),
                                          onPressed: () async {
                                            if (!controller.verifyOtp) {
                                              if (_formKeyMob.currentState!
                                                  .validate()) {
                                                // handleGenerateOtp();
                                                controller
                                                    .handleGenerateOtp(context);
                                              }
                                            } else {
                                              controller
                                                  .handleVerifyOtp(context);
                                            }
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    15 * fem,
                                                    0 * fem,
                                                    15 * fem),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.8,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      !controller.verifyOtp
                                                          ? TextConstant.sendOtp
                                                          : TextConstant.submit,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 14 * fem,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        height:
                                                            1.1725 * fem / fem,
                                                        color:
                                                            Color(0xffffffff),
                                                        letterSpacing: 0.5,
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
                      ])),
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
        borderRadius: BorderRadius.circular(4 * fem),
        border: Border.all(color: AppColors.F1F1F1),
      ),
      child: Center(
        child: TextField(
          autofocus: true,
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
              fontSize: 18, fontWeight: FontWeight.w300, fontFamily: "Dm Sans"),
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
