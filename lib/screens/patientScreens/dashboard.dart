import 'package:CarePay/components/transactionCard.dart';
import 'package:CarePay/screens/patientScreens/menuScreen.dart';
import 'package:CarePay/view_model/patientFlow/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashboardState();
  }
}

class DashboardState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<DashboardController>(context, listen: false);
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
    final controller = Provider.of<DashboardController>(context);
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
            backgroundColor: AppColors.white,
            key: _key,
            drawer: Drawer(
                width: MediaQuery.of(context).size.width / 1.2,
                child: MenuScreen()),
            appBar: AppBar(
                backgroundColor: AppColors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(color: AppColors.white),
                ),
                //leading: Padding(padding:EdgeInsets.only(top: 100),),
                title: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.menu,
                        size: 30,
                        color: AppColors.primaryPurple.withOpacity(0.7),
                      ),
                      onTap: () {
                        _key.currentState?.openDrawer();
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5 * fem),
                          Container(
                            width: 115 * fem,
                            height: 45 * fem,
                            // padding: EdgeInsets.only(top: 25),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/carePayLogo.png')),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () async {
                        Uri phoneno =
                            Uri.parse('tel:${TextConstant.helpNumber}');
                        if (await launchUrl(phoneno)) {
                          //dialer opened
                        } else {
                          //dailer is not opened
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: AppColors.primaryPurple),
                            color: AppColors.tertiaryOrange,
                            borderRadius: BorderRadius.circular(8 * fem)),
                        child: Padding(
                          padding: EdgeInsets.all(7 * fem),
                          child: Row(
                            children: [
                              Text(TextConstant.help,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.primaryPurple,
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w700)),
                              Icon(
                                Icons.headset_mic,
                                size: 25 * fem,
                                color: AppColors.primaryPurple,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            body: !controller.loading
                ? SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              15 * fem, 0 * fem, 15 * fem, 0 * fem),
                          height: MediaQuery.of(context).size.height / 1.14,
                          // color: Colors.red,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 15 * fem, 0 * fem, 15 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                  child: FadeSlideTransition(
                                    additionalOffset: space,
                                    animation: _formElementAnimation,
                                    child: Text(
                                      'Hi! ${controller.userDetailResponse['firstName'].toString()}',
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 20 * fem,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                  child: FadeSlideTransition(
                                    additionalOffset: space,
                                    animation: _formElementAnimation,
                                    child: Text(
                                      TextConstant.current,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 10 * fem),
                                  child: FadeSlideTransition(
                                    additionalOffset: space,
                                    animation: _formElementAnimation,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                      padding: EdgeInsets.fromLTRB(15 * fem,
                                          20 * fem, 15 * fem, 20 * fem),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: AppColors.ECEBFF,
                                          borderRadius:
                                              BorderRadius.circular(10 * fem)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '₹ ${controller.loanDetailResponse != null ? controller.loanDetailResponse['amount'].toString() : 0}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize:
                                                                  16 * fem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 6 * fem,
                                                        ),
                                                        Text(
                                                          TextConstant
                                                              .totalCredit,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  12 * fem,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                    height: 20 * fem,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '₹ ${controller.firstUnpaidData != null ? controller.firstUnpaidData['repayment_amount'].toString() : 0}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize:
                                                                  16 * fem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 6 * fem,
                                                        ),
                                                        Text(
                                                          TextConstant
                                                              .nextInstallment,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  12 * fem,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                height: 1,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          controller.loanEmi
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize:
                                                                  16 * fem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 6 * fem,
                                                        ),
                                                        Text(
                                                          TextConstant.tenure,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  12 * fem,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 1,
                                                    height: 20 * fem,
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(DateTime.parse(controller
                                                                  .firstUnpaidData[
                                                                      'repayment_date']
                                                                  .toString())),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize:
                                                                  16 * fem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 6 * fem,
                                                        ),
                                                        Text(
                                                          TextConstant.date,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize:
                                                                  12 * fem,
                                                              color: AppColors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          if (controller.loanEmi > 0) ...[
                                            Container(

                                                // group167cge (455:270)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    20 * fem,
                                                    0 * fem,
                                                    10 * fem),
                                                width: double.infinity,
                                                // decoration: BoxDecoration(
                                                //   borderRadius: BorderRadius.circular(12 * fem),
                                                // ),
                                                child: FadeSlideTransition(
                                                    animation:
                                                        _formElementAnimation,
                                                    additionalOffset: space,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${controller.paidCount.toString()}${TextConstant.qEmi}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize:
                                                                  14 * fem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 10 * fem,
                                                        ),
                                                        Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              for (var index =
                                                                      1;
                                                                  index <=
                                                                      controller
                                                                          .loanEmi;
                                                                  index++) ...[
                                                                Container(
                                                                  width: controller
                                                                              .loanEmi ==
                                                                          6
                                                                      ? MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          7.4
                                                                      : MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          3.6,
                                                                  height:
                                                                      6 * fem,
                                                                  decoration: BoxDecoration(
                                                                      color: index <= controller.paidCount
                                                                          ? AppColors
                                                                              .primaryPurple
                                                                          : AppColors
                                                                              .transparent,
                                                                      border: Border.all(
                                                                          color: AppColors
                                                                              .primaryPurple,
                                                                          width:
                                                                              0.5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(10 *
                                                                              fem)),
                                                                ),
                                                              ]
                                                              // Container(
                                                              //   width: MediaQuery.of(context)
                                                              //           .size
                                                              //           .width /
                                                              //       3.6,
                                                              //   height: 6 * fem,
                                                              //   decoration: BoxDecoration(
                                                              //       color:
                                                              //           AppColors.primaryPurple,
                                                              //       borderRadius:
                                                              //           BorderRadius.circular(
                                                              //               10 * fem)),
                                                              // ),
                                                              // Container(
                                                              //   width: MediaQuery.of(context)
                                                              //           .size
                                                              //           .width /
                                                              //       3.6,
                                                              //   height: 6 * fem,
                                                              //   decoration: BoxDecoration(
                                                              //       color:
                                                              //           AppColors.primaryPurple,
                                                              //       borderRadius:
                                                              //           BorderRadius.circular(
                                                              //               10 * fem)),
                                                              // ),
                                                            ]),
                                                      ],
                                                    ))),
                                          ],
                                          Container(

                                              // group167cge (455:270)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem,
                                                  10 * fem),
                                              width: double.infinity,
                                              // decoration: BoxDecoration(
                                              //   borderRadius: BorderRadius.circular(12 * fem),
                                              // ),
                                              child: FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: space,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0)),
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        0 * fem,
                                                                        0 * fem,
                                                                        0 * fem,
                                                                        0 *
                                                                            fem),
                                                                primary: AppColors
                                                                    .transparent,
                                                                onSurface: AppColors
                                                                    .transparent,
                                                                shadowColor:
                                                                    AppColors
                                                                        .transparent,
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primaryPurple),
                                                            onPressed: () {
                                                              // Navigator.push(
                                                              //   context,
                                                              //   PageTransition(
                                                              //       type: PageTransitionType
                                                              //           .rightToLeftWithFade,
                                                              //       child: DashboardScreen()),
                                                              // );
                                                            },
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 *
                                                                              fem,
                                                                          15 *
                                                                              fem,
                                                                          0 *
                                                                              fem,
                                                                          15 *
                                                                              fem),
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.8,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Text(
                                                                        TextConstant
                                                                            .payNext,
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'DM Sans',
                                                                          // 'Work Sans',
                                                                          fontSize:
                                                                              14 * fem,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          height: 1.1725 *
                                                                              fem /
                                                                              fem,
                                                                          color:
                                                                              Color(0xffffffff),
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
                                                  ))),
                                          Container(

                                              // group167cge (455:270)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  5 * fem,
                                                  0 * fem,
                                                  5 * fem),
                                              width: double.infinity,
                                              // decoration: BoxDecoration(
                                              //   borderRadius: BorderRadius.circular(12 * fem),
                                              // ),
                                              child: FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: space,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        TextConstant
                                                            .loanDisbursed,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12 * fem,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                      Text(
                                                        controller.loanDetailResponse[
                                                                    'tenure_date'] !=
                                                                null
                                                            ? DateFormat(
                                                                    'dd/MM/yyyy,  hh:mm a')
                                                                .format(DateTime.parse(controller
                                                                    .loanDetailResponse[
                                                                        'tenure_date']
                                                                    .toString()))
                                                            : "",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontSize: 12 * fem,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: AppColors
                                                                .black),
                                                      ),
                                                    ],
                                                  ))),
                                          Container(

                                              // group167cge (455:270)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  5 * fem,
                                                  0 * fem,
                                                  5 * fem),
                                              width: double.infinity,
                                              // decoration: BoxDecoration(
                                              //   borderRadius: BorderRadius.circular(12 * fem),
                                              // ),
                                              child: FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: space,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        TextConstant.totalDue,
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 12 * fem,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                      Text(
                                                        '₹ ${controller.loanDetailResponse['due_amount'] != null ? controller.loanDetailResponse['due_amount'].toString() : 0}',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 12 * fem,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.8)),
                                                      ),
                                                    ],
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  // group167cge (455:270)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 25 * fem, 0 * fem, 5 * fem),
                                  width: double.infinity,
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(12 * fem),
                                  // ),
                                  child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      additionalOffset: space,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            TextConstant.myTransactions,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontSize: 16 * fem,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                15 * fem, 0 * fem, 15 * fem),
                                            child: FadeSlideTransition(
                                                animation:
                                                    _formElementAnimation,
                                                additionalOffset: space,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    // for (var i = 0;
                                                    //     i < 6;
                                                    //     i++) ...[
                                                    //   TransactionCard(),
                                                    // ],
                                                    Image.asset(
                                                        "assets/images/noTransactions.png",
                                                        height: 100 * fem),
                                                    SizedBox(
                                                      width: 1,
                                                      height: 5 * fem,
                                                    ),
                                                    Text(
                                                      "No transactions found",
                                                      style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          fontSize: 14 * fem,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                )),
                                          )
                                        ],
                                      )),
                                ),
                                // Container(
                                //   // group167cge (455:270)
                                //   margin: EdgeInsets.fromLTRB(
                                //       0 * fem, 20 * fem, 0 * fem, 20 * fem),
                                //   width: double.infinity,
                                //   // decoration: BoxDecoration(
                                //   //   borderRadius: BorderRadius.circular(12 * fem),
                                //   // ),
                                //   child: FadeSlideTransition(
                                //       animation: _formElementAnimation,
                                //       additionalOffset: space,
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           InkWell(
                                //             onTap: () {
                                //               print(":contact tap");
                                //             },
                                //             child: Text(
                                //               TextConstant.contactSupport,
                                //               style: TextStyle(
                                //                 fontFamily: 'DM Sans',
                                //                 shadows: [
                                //                   Shadow(
                                //                       color: AppColors
                                //                           .primaryPurple,
                                //                       offset: Offset(0, -5))
                                //                 ],
                                //                 decoration:
                                //                     TextDecoration.underline,
                                //                 fontSize: 14 * fem,
                                //                 decorationColor:
                                //                     AppColors.primaryPurple,
                                //                 decorationThickness: 4,
                                //                 fontWeight: FontWeight.w700,
                                //                 color: Colors.transparent,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       )),
                                // ),
                                // Container(
                                //     // group167cge (455:270)
                                //     margin: EdgeInsets.fromLTRB(
                                //         0 * fem, 6 * fem, 0 * fem, 10 * fem),
                                //     padding: EdgeInsets.fromLTRB(
                                //         10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                //     width: double.infinity,
                                //     // decoration: BoxDecoration(
                                //     //   borderRadius: BorderRadius.circular(12 * fem),
                                //     // ),
                                //     child: FadeSlideTransition(
                                //         animation: _formElementAnimation,
                                //         additionalOffset: space,
                                //         child: Container(
                                //           padding: EdgeInsets.fromLTRB(15 * fem,
                                //               10 * fem, 15 * fem, 10 * fem),
                                //           width: double.infinity,
                                //           decoration: BoxDecoration(
                                //               color: AppColors.ECEBFF,
                                //               borderRadius:
                                //                   BorderRadius.circular(
                                //                       10 * fem)),
                                //           child: Row(
                                //             mainAxisAlignment:
                                //                 MainAxisAlignment.spaceBetween,
                                //             children: [
                                //               Text(
                                //                 TextConstant.loanAgreement,
                                //                 style: TextStyle(
                                //                     fontFamily: 'DM Sans',
                                //                     fontSize: 14 * fem,
                                //                     fontWeight: FontWeight.w700,
                                //                     color: AppColors
                                //                         .primaryPurple),
                                //               ),
                                //               Icon(
                                //                 Icons.download,
                                //                 size: 30,
                                //                 color: AppColors.primaryPurple,
                                //               )
                                //             ],
                                //           ),
                                //         )))
                              ],
                            ),
                          ),
                        )
                      ]))
                : Container()),
      ),
    );
  }
}
