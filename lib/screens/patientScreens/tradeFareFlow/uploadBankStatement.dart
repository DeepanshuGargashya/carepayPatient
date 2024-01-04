import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/emiPlans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:provider/provider.dart';
import '../../../res/textConstant.dart';
import '../../../view_model/patientFlow/bankStatementController.dart';

class UploadBankStatementScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UploadBankStatementState();
  }
}

class UploadBankStatementState extends State<UploadBankStatementScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyPassword = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<BankStatementController>(context, listen: false);
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

  // state variables

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<BankStatementController>(context);
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
          // Navigator.pushReplacement(
          //   context,
          //   PageTransition(
          //       type: PageTransitionType.rightToLeftWithFade,
          //       child: BAnkStatementCollection()),
          // );

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
                  // Navigator.pushReplacement(
                  //   context,
                  //   PageTransition(
                  //       type: PageTransitionType.rightToLeftWithFade,
                  //       child: BAnkStatementCollection()),
                  // );
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
                    EdgeInsets.fromLTRB(10 * fem, 20 * fem, 10 * fem, 0 * fem),
                child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      Container(
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: Text(
                              TextConstant.bankAccount,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * fem),
                            )),
                      ),
                      Container(
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 15 * fem, 0 * fem, 0 * fem),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              // additionalOffset: fem,
                              additionalOffset: 0.0,
                              child: Container(
                                // emailidwU2 (455:267)
                                decoration: BoxDecoration(
                                    color: AppColors.ECEBFF,
                                    borderRadius:
                                        BorderRadius.circular(10 * fem)),
                                // margin: EdgeInsets.fromLTRB(
                                //     10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    15 * fem, 10 * fem, 15 * fem, 10 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.uploadBank,
                                    style: TextStyle(
                                      // 'Work Sans',
                                      fontFamily: "DM Sans",
                                      letterSpacing: 0.5,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.1725 * ffem / fem,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${DateFormat.yMMMM().format(new DateTime(DateTime.now().year, DateTime.now().month - 2, DateTime.now().day)).toString()}',
                                    style: TextStyle(
                                      // 'Work Sans',
                                      fontFamily: "DM Sans",
                                      letterSpacing: 0.5,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.1725 * ffem / fem,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                  TextSpan(
                                    text: TextConstant.to,
                                    style: TextStyle(
                                      // 'Work Sans',
                                      fontFamily: "DM Sans",
                                      letterSpacing: 0.5,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.1725 * ffem / fem,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        '${DateFormat.yMMMM().format(DateTime.now()).toString()}',
                                    style: TextStyle(
                                      // 'Work Sans',
                                      fontFamily: "DM Sans",
                                      letterSpacing: 0.5,
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.1725 * ffem / fem,
                                      color: AppColors.primaryPurple,
                                    ),
                                  ),
                                ])),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        // height: MediaQuery.of(context).size.height / 1.4,
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.215,
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (controller.firstMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.45),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: AppColors
                                                          .primaryPurple,
                                                      size: 24 * fem,
                                                    ),
                                                    SizedBox(
                                                      width: 10 * fem,
                                                      height: 1,
                                                    ),
                                                    Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9),
                                                      child: Text(
                                                        '${controller.firstMonthName.toString()}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 14 * fem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primaryPurple),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .setEmpty("first");
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        size: 20 * fem,
                                                      )))
                                            ]
                                          ],
                                        ),
                                        SizedBox(
                                          width: 1,
                                          height: 10 * fem,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (controller.secondMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.45),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: AppColors
                                                          .primaryPurple,
                                                      size: 24 * fem,
                                                    ),
                                                    SizedBox(
                                                      width: 10 * fem,
                                                      height: 1,
                                                    ),
                                                    Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9),
                                                      child: Text(
                                                        '${controller.secondMonthName.toString()}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 14 * fem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primaryPurple),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .setEmpty("second");
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        size: 20 * fem,
                                                      )))
                                            ]
                                          ],
                                        ),
                                        SizedBox(
                                          width: 1,
                                          height: 10 * fem,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            if (controller.thirdMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              Container(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.45),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.check_circle,
                                                      color: AppColors
                                                          .primaryPurple,
                                                      size: 24 * fem,
                                                    ),
                                                    SizedBox(
                                                      width: 10 * fem,
                                                      height: 1,
                                                    ),
                                                    Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1.9),
                                                      child: Text(
                                                        '${controller.thirdMonthName.toString()}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 14 * fem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: AppColors
                                                                .primaryPurple),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  child: IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .setEmpty("third");
                                                      },
                                                      icon: Icon(
                                                        Icons.cancel,
                                                        size: 20 * fem,
                                                      )))
                                            ]
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 10 * fem,
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 15 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${TextConstant.uploaded}',
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontSize: 16 * fem,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.black
                                                  .withOpacity(0.4)),
                                        ),
                                        SizedBox(
                                          width: 1,
                                          height: 15 * fem,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            if (controller.firstMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              SizedBox(
                                                width: 52 * fem,
                                                height: 64 * fem,
                                                child: Image.asset(
                                                    'assets/images/icPdf.png'),
                                              )
                                            ],
                                            SizedBox(
                                              width: 10 * fem,
                                              height: 1,
                                            ),
                                            if (controller.secondMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              SizedBox(
                                                width: 52 * fem,
                                                height: 64 * fem,
                                                child: Image.asset(
                                                    'assets/images/icPdf.png'),
                                              )
                                            ],
                                            SizedBox(
                                              width: 10 * fem,
                                              height: 1,
                                            ),
                                            if (controller.thirdMonth
                                                    .toString()
                                                    .length >
                                                0) ...[
                                              SizedBox(
                                                width: 52 * fem,
                                                height: 64 * fem,
                                                child: Image.asset(
                                                    'assets/images/icPdf.png'),
                                              )
                                            ],
                                            if (!(controller.firstMonth
                                                        .toString()
                                                        .length >
                                                    0) ||
                                                !(controller.secondMonth
                                                        .toString()
                                                        .length >
                                                    0) ||
                                                !(controller.thirdMonth
                                                        .toString()
                                                        .length >
                                                    0)) ...[
                                              InkWell(
                                                onTap: () {
                                                  if (!(controller.firstMonth
                                                          .toString()
                                                          .length >
                                                      0)) {
                                                    controller.openFiles(
                                                        'firstMonth');
                                                  } else if (!(controller
                                                          .secondMonth
                                                          .toString()
                                                          .length >
                                                      0)) {
                                                    controller.openFiles(
                                                        'secondMonth');
                                                  } else {
                                                    controller.openFiles(
                                                        'thirdMonth');
                                                  }
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      15 * fem,
                                                      10 * fem,
                                                      15 * fem,
                                                      10 * fem),
                                                  margin: EdgeInsets.fromLTRB(
                                                      15 * fem,
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem),
                                                  decoration: BoxDecoration(
                                                      color: AppColors.ECEBFF,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10 * fem)),
                                                  child: Column(
                                                    children: [
                                                      Image.asset(
                                                          'assets/images/icAdd.png'),
                                                      SizedBox(
                                                        width: 1,
                                                        height: 10 * fem,
                                                      ),
                                                      Text(
                                                        TextConstant.uploadPdf,
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          color: AppColors
                                                              .primaryPurple,
                                                          fontSize: 14 * fem,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),

                      // Raj works start

                      FadeSlideTransition(
                        additionalOffset: space,
                        animation: _formElementAnimation,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8 * fem),
                            Row(
                              children: [
                                Text(TextConstant.password,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.black,
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400)),
                                SizedBox(width: 10),
                                Container(
                                  // padding: EdgeInsets.only(top: 25),
                                  child: Image(
                                      image: AssetImage(
                                          'assets/images/informatio.png')),
                                ),
                              ],
                            ),
                            SizedBox(height: 8 * fem),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 100, 0),
                              child: Text(TextConstant.kindlyEnter,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      height: 1.18 * fem,
                                      color: AppColors.primaryPurple,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12 * fem)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyPassword,
                                child: TextFormField(
                                  obscureText: controller.passwordVisible,
                                  controller: controller.passwordController,
                                  onChanged: (value) {
                                    _formKeyPassword.currentState!.validate();
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(controller.passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility),
                                        onPressed: () {
                                          controller.setPasswordVisible("pass");
                                        },
                                      ),
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterHere,

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

                                      // return TextConstant.enterValidPass;
                                      return TextConstant.noPassword;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 8 * fem),
                            Text(TextConstant.encrypted,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.primaryGreen,
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400)),
                            SizedBox(height: 18 * fem),
                          ],
                        ),
                      ),

                      // Raj works end

                      // if (!(controller.firstMonth.toString().length > 0) ||
                      //     !(controller.secondMonth.toString().length > 0)) ...[
                      //   Container(
                      //     // group167cge (455:270)
                      //     margin: EdgeInsets.fromLTRB(
                      //         0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      //     // width: MediaQuery.of(context).size.width / 1.2,
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(12 * fem),
                      //     ),
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         InkWell(
                      //           onTap: () {
                      //             if (!(controller.firstMonth.toString().length >
                      //                 0)) {
                      //               controller.openFiles('firstMonth');
                      //             } else if (!(controller.secondMonth
                      //                     .toString()
                      //                     .length >
                      //                 0)) {
                      //               controller.openFiles('secondMonth');
                      //             } else {
                      //               controller.openFiles('thirdMonth');
                      //             }
                      //           },
                      //           child: FadeSlideTransition(
                      //             animation: _formElementAnimation,
                      //             // additionalOffset: fem,
                      //             additionalOffset: 0.0,
                      //             child: Container(
                      //                 // emailidwU2 (455:267)
                      //                 decoration: BoxDecoration(
                      //                     color: AppColors.ECEBFF,
                      //                     borderRadius:
                      //                         BorderRadius.circular(10 * fem)),
                      //                 // margin: EdgeInsets.fromLTRB(
                      //                 //     10 * fem, 10 * fem, 10 * fem, 10 * fem),
                      //                 padding: EdgeInsets.fromLTRB(
                      //                     15 * fem, 10 * fem, 15 * fem, 10 * fem),
                      //                 child: Row(
                      //                   children: [
                      //                     Icon(
                      //                       Icons.arrow_upward,
                      //                       size: 24 * fem,
                      //                       color: AppColors.primaryPurple,
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12 * fem,
                      //                       height: 1,
                      //                     ),
                      //                     Text(
                      //                       TextConstant.uploadBankStatementPdf,
                      //                       style: TextStyle(
                      //                           color: AppColors.primaryPurple,
                      //                           fontSize: 14 * fem,
                      //                           fontWeight: FontWeight.w700),
                      //                     )
                      //                   ],
                      //                 )),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // // ] else ...[
                      Container(
                          // padding: EdgeInsets.fromLTRB(
                          //     12 * fem, 0 * fem, 12 * fem, 0 * fem),
                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15 * fem),
                          ),
                          child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: space,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.fromLTRB(8 * fem,
                                              14 * fem, 8 * fem, 14 * fem),
                                          primary: AppColors.transparent,
                                          onSurface: AppColors.transparent,
                                          shadowColor: AppColors.transparent,
                                          backgroundColor: controller.thirdMonth
                                                          .toString()
                                                          .length >
                                                      0 ||
                                                  controller.secondMonth
                                                          .toString()
                                                          .length >
                                                      0 ||
                                                  controller.firstMonth
                                                          .toString()
                                                          .length >
                                                      0
                                              ? AppColors.primaryPurple
                                              : AppColors.primaryPurple
                                                  .withOpacity(0.4)),
                                      onPressed: () {
                                        // setState(() {
                                        if (controller.thirdMonth
                                                    .toString()
                                                    .length >
                                                0 ||
                                            controller.secondMonth
                                                    .toString()
                                                    .length >
                                                0 ||
                                            controller.firstMonth
                                                    .toString()
                                                    .length >
                                                0) {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType
                                                    .rightToLeftWithFade,
                                                child: EmiPlansScreen()),
                                          );
                                          if (_formKeyPassword.currentState!
                                              .validate()) {
                                            controller.handleSubmition(context);
                                          }
                                        }
                                        // Navigator.push(
                                        //   context,
                                        //   PageTransition(
                                        //       type: PageTransitionType
                                        //           .rightToLeftWithFade,
                                        //       child:
                                        //           UploadBankStatementScreen()),
                                        // );
                                        // });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            TextConstant.continues,
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
                          )),
                      // ]
                    ])))),
      ),
    );
  }
}
