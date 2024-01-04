import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/employmentDetails.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/successfullyFetched.dart';
import 'package:CarePay/view_model/patientFlow/bankDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:provider/provider.dart';
import '../../../res/textConstant.dart';
import '../../../utils/utils.dart';

class BankDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BankDetailState();
  }
}

class BankDetailState extends State<BankDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyBankName = GlobalKey<FormState>();
  final _formKeyBranchCode = GlobalKey<FormState>();
  final _formKeyAccountNumber = GlobalKey<FormState>();
  final _formKeyConfirmAccountNumber = GlobalKey<FormState>();
  final _formKeyIfscCode = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<BankDetailController>(context, listen: false);
      fetchData.initFetchData(context);
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
    final controller = Provider.of<BankDetailController>(context);
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
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: const SuccessfullyFetched()),
          );

          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              centerTitle: false,
              // leadingWidth: 0,
              titleSpacing: 0,
              title: Text(
                TextConstant.loanApplicationn,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: EmploymentDetailScreen()),
                  );
                },
              ),
              // title: Container(
              //     alignment: Alignment.centerLeft,
              //     // group167cge (455:270)
              //     padding: EdgeInsets.fromLTRB(5 * fem, 10 * fem, 5 * fem, 0 * fem),
              //     margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
              //     width: double.infinity,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(4 * fem),
              //     ),
              //     child: Image.asset(
              //       'assets/images/carePayLogo.png',
              //       width: 143 * fem,
              //       height: 61 * fem,
              //     )),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(15 * fem),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        LinearPercentIndicator(
                          barRadius: Radius.circular(10 * fem),
                          backgroundColor: AppColors.tertiaryOrange,
                          width: MediaQuery.of(context).size.width,
                          lineHeight: 8 * fem,
                          percent: 0.45,
                          progressColor: AppColors.primaryPurple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            body: Padding(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 0 * fem),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        width: 1,
                        height: 20 * fem,
                      ),
                      Container(
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: Text(
                              TextConstant.bankCollection,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * fem),
                            )),
                      ),
                      FadeSlideTransition(
                        additionalOffset: space,
                        animation: _formElementAnimation,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.tertiaryOrange,
                              borderRadius: BorderRadius.circular(4 * fem)),
                          padding:
                              EdgeInsets.fromLTRB(10 * fem, 15, 10 * fem, 15),
                          child: Text.rich(
                              textAlign: TextAlign.center,
                              TextSpan(children: <InlineSpan>[
                                TextSpan(
                                  text: TextConstant.bankPlease(first: true),
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400),
                                ),
                                TextSpan(
                                  text: TextConstant.bankPlease(second: true),
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w700),
                                ),
                                TextSpan(
                                  text: TextConstant.bankPlease(
                                      first: false, second: false),
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400),
                                ),
                              ])),
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text(TextConstant.accountNumber,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyAccountNumber,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      controller.accountNumberController,
                                  obscureText: controller.passwordVisible,
                                  enableSuggestions: false,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      _formKeyAccountNumber.currentState!
                                          .validate();
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enteracountNumber,
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(controller.passwordVisible
                                      //       ? Icons.visibility_off
                                      //       : Icons.visibility),
                                      //   onPressed: () {
                                      //     controller.setPasswordVisible("pass");
                                      //   },
                                      // ),
                                      // border : InputBorder.none,

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                      return TextConstant.enteracountNumberr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.confirmAcountNumber,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyConfirmAccountNumber,
                                child: TextFormField(
                                  obscureText:
                                      controller.confirmPasswordVisible,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.number,
                                  enableInteractiveSelection: false,
                                  controller:
                                      controller.confirmAccountNumberController,
                                  onChanged: (value) {
                                    if (value.length ==
                                        controller.accountNumberController.text
                                            .toString()
                                            .length) {
                                      if (controller
                                          .accountNumberController.text
                                          .toString()
                                          .startsWith(value)) {
                                        _formKeyConfirmAccountNumber
                                            .currentState!
                                            .validate();
                                      } else {
                                        return null;
                                      }
                                    } else {
                                      // formKeyConfirmAccount.currentState!
                                      //     .validate();
                                      return null;
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText:
                                          TextConstant.reenteracountNumber,
                                      // suffixIcon: null,
                                      // border : InputBorder.none,
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(controller.confirmPasswordVisible
                                      //       ? Icons.visibility_off
                                      //       : Icons.visibility),
                                      //   onPressed: () {
                                      //     controller.setPasswordVisible("cpass");
                                      //   },
                                      // ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return TextConstant.reenteracountNumberrr;
                                      // if(){}
                                    }
                                    if (value !=
                                        controller.accountNumberController.text
                                            .toString()) {
                                      return TextConstant.acountNumberNotMatch;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.ifsc,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyIfscCode,
                                child: TextFormField(
                                  maxLength: 11,
                                  controller: controller.ifscCodeController,
                                  onChanged: (value) async {
                                    controller.ifscCodeController.value =
                                        TextEditingValue(
                                            text: value.toUpperCase(),
                                            selection: controller
                                                .ifscCodeController.selection);
                                    if (value.length == 11) {
                                      var res = await controller
                                          .fetchIFSCCodeDetail();
                                      if (res) {
                                        _formKeyIfscCode.currentState!
                                            .validate();
                                      }
                                    }
                                    if (value.length > 9) {
                                      // formKeyIfsc.currentState!.validate();
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterIfsc,

                                      // border : InputBorder.none,

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return TextConstant.enterIfscc;
                                    } else if (value.length < 11) {
                                      return TextConstant.invalidIfsc;
                                    } else if (controller.ifscErrorCode) {
                                      return TextConstant.invalidIfsc;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 12 * fem),
                              child: Text(TextConstant.bankName,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyBankName,
                                child: TextFormField(
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  focusNode: FocusNode(),
                                  controller: controller.bankNameController,
                                  onChanged: (value) {
                                    if (value.length > 2) {
                                      _formKeyBankName.currentState!.validate();
                                    }
                                  },
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: 'DM Sans',
                                  ),
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: "Bank Name",

                                      // border : InputBorder.none,

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                      return TextConstant.plsEnterBankName;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 12 * fem),
                              child: Text(TextConstant.branchName,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyBranchCode,
                                child: TextFormField(
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  focusNode: FocusNode(),
                                  controller: controller.branchCodeController,
                                  onChanged: (value) {
                                    if (value.length > 2) {
                                      _formKeyBranchCode.currentState!
                                          .validate();
                                    }
                                  },
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontFamily: 'DM Sans',
                                  ),
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: "Bank Name",

                                      // border : InputBorder.none,

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                      return TextConstant.plsEnterBranchName;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      Container(

                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 20 * fem, 0 * fem, 10 * fem),
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
                                        onPressed: () {
                                          if (!controller.ifscErrorCode) {
                                            if (_formKeyAccountNumber
                                                    .currentState!
                                                    .validate() &&
                                                _formKeyConfirmAccountNumber
                                                    .currentState!
                                                    .validate() &&
                                                _formKeyIfscCode.currentState!
                                                    .validate() &&
                                                _formKeyBankName.currentState!
                                                    .validate()) {
                                              // controller
                                              // .handleSubmition(context);
                                              controller.handleTemp(context);
                                            } else {
                                              _formKeyAccountNumber
                                                  .currentState!
                                                  .validate();
                                              _formKeyConfirmAccountNumber
                                                  .currentState!
                                                  .validate();
                                              _formKeyIfscCode.currentState!
                                                  .validate();
                                              _formKeyBankName.currentState!
                                                  .validate();
                                            }
                                          } else {
                                            Utils.toastMessage(
                                                "Invalid IFSC code");
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
                                                    TextConstant.submit,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      // 'Work Sans',
                                                      fontSize: 14 * fem,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height:
                                                          1.1725 * fem / fem,
                                                      color: Color(0xffffffff),
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
                    ])))),
      ),
    );
  }
}
