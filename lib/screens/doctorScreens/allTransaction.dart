import 'package:CarePay/components/doctorTransactionsCard.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/allTransactionController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import '../../res/textConstant.dart';

class AllTransactionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AllTransactionState();
  }
}

class AllTransactionState extends State<AllTransactionScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<AllTransactionController>(context, listen: false);
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

  var transactionTab = "allLoans";

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AllTransactionController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    var barHeight = Get.statusBarHeight;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              TextConstant.transactions,
              style: TextStyle(
                  fontFamily: 'DM Sans',
                  fontSize: 18 * fem,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: AppColors.white),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 0 * fem, 10 * fem, 0 * fem),
                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12 * fem),
                          ),
                          child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            // additionalOffset: fem,
                            additionalOffset: 0.0,
                            child: Container(
                                // emailidwU2 (455:267)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 1 * fem),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width:
                                                  transactionTab == "allLoans"
                                                      ? 2.0
                                                      : 0.0,
                                              color:
                                                  transactionTab == "allLoans"
                                                      ? AppColors.primaryPurple
                                                          .withOpacity(0.4)
                                                      : AppColors.white),
                                        ),
                                      ),
                                      child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              transactionTab = "allLoans";
                                            });
                                            controller.fetchLoans(
                                                status: "",
                                                countOf: "allLoans",
                                                reset: true);
                                          },
                                          child: Text.rich(
                                              TextSpan(children: <InlineSpan>[
                                            TextSpan(
                                              text: TextConstant.allLoans,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  color: transactionTab ==
                                                          "allLoans"
                                                      ? AppColors.primaryPurple
                                                      : AppColors.black
                                                          .withOpacity(0.4),
                                                  fontSize: 12 * fem,
                                                  fontWeight: transactionTab ==
                                                          "allLoans"
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                            ),
                                            TextSpan(
                                              text:
                                                  ' (${controller.allLoanCount.toString()})',
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  color: transactionTab ==
                                                          "allLoans"
                                                      ? AppColors.primaryPurple
                                                          .withOpacity(0.4)
                                                      : AppColors.black
                                                          .withOpacity(0.4),
                                                  fontSize: 12 * fem,
                                                  fontWeight: transactionTab ==
                                                          "allLoans"
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                            ),
                                          ])),
                                          style: TextButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        5 * ffem)),
                                            primary: AppColors.primaryPurple,
                                            backgroundColor: Color.fromARGB(
                                                255, 253, 251, 251),
                                          )),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width:
                                                  transactionTab == "disbursed"
                                                      ? 2.0
                                                      : 0.0,
                                              color:
                                                  transactionTab == "disbursed"
                                                      ? AppColors.primaryPurple
                                                          .withOpacity(0.4)
                                                      : AppColors.white),
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            transactionTab = "disbursed";
                                          });
                                          controller.fetchLoans(
                                              status: "disbursed",
                                              countOf: "disbursed",
                                              reset: true);
                                        },
                                        child: Text.rich(
                                            TextSpan(children: <InlineSpan>[
                                          TextSpan(
                                            text: TextConstant.disbursed,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: transactionTab ==
                                                        "disbursed"
                                                    ? AppColors.primaryPurple
                                                    : AppColors.black
                                                        .withOpacity(0.4),
                                                fontSize: 12 * fem,
                                                fontWeight: transactionTab ==
                                                        "disbursed"
                                                    ? FontWeight.w500
                                                    : FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${controller.disbursedCount.toString()})',
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: transactionTab ==
                                                        "disbursed"
                                                    ? AppColors.primaryPurple
                                                        .withOpacity(0.4)
                                                    : AppColors.black
                                                        .withOpacity(0.4),
                                                fontSize: 12 * fem,
                                                fontWeight: transactionTab ==
                                                        "disbursed"
                                                    ? FontWeight.w500
                                                    : FontWeight.w400),
                                          ),
                                        ])),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5 * ffem)),
                                          primary: AppColors.primaryPurple,
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 251, 251),
                                          // onSurface: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              width:
                                                  transactionTab == "approved"
                                                      ? 2.0
                                                      : 0.0,
                                              color:
                                                  transactionTab == "approved"
                                                      ? AppColors.primaryPurple
                                                          .withOpacity(0.4)
                                                      : AppColors.white),
                                        ),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            transactionTab = "approved";
                                          });
                                          controller.fetchLoans(
                                              status: "approved",
                                              countOf: "approved",
                                              reset: true);
                                        },
                                        child: Text.rich(
                                            TextSpan(children: <InlineSpan>[
                                          TextSpan(
                                            text: TextConstant.approved,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: transactionTab ==
                                                        "approved"
                                                    ? AppColors.primaryPurple
                                                    : AppColors.black
                                                        .withOpacity(0.4),
                                                fontSize: 12 * fem,
                                                fontWeight:
                                                    transactionTab == "approved"
                                                        ? FontWeight.w500
                                                        : FontWeight.w400),
                                          ),
                                          TextSpan(
                                            text:
                                                ' (${controller.approvedCount.toString()})',
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: transactionTab ==
                                                        "approved"
                                                    ? AppColors.primaryPurple
                                                        .withOpacity(0.4)
                                                    : AppColors.black
                                                        .withOpacity(0.4),
                                                fontSize: 12 * fem,
                                                fontWeight:
                                                    transactionTab == "approved"
                                                        ? FontWeight.w500
                                                        : FontWeight.w400),
                                          ),
                                        ])),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5 * ffem)),
                                          primary: AppColors.primaryPurple,
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 251, 251),
                                          // onSurwface: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 2 * fem,
                          color: AppColors.black.withOpacity(0.1),
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                10 * fem, 0 * fem, 10 * fem, 0 * fem),
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12 * fem),
                            ),
                            child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              // additionalOffset: fem,
                              additionalOffset: 0.0,
                              child: Column(
                                children: [
                                  NotificationListener<ScrollEndNotification>(
                                    onNotification: (scrollEnd) {
                                      final metrics = scrollEnd.metrics;
                                      if (metrics.atEdge) {
                                        bool isTop = metrics.pixels == 0;
                                        if (isTop) {
                                          print('At the top');
                                        } else {
                                          print('At the Bottom');
                                          print(controller.isListEnd);
                                          print(DateTime
                                              .fromMillisecondsSinceEpoch(
                                                  1680105003388));
                                          if (!controller.isListEnd) {
                                            if (transactionTab == "allLoans") {
                                              controller.fetchLoans(
                                                  status: "",
                                                  countOf: "allLoans",
                                                  reset: false);
                                            } else if (transactionTab ==
                                                "disbursed") {
                                              controller.fetchLoans(
                                                  status: "disbursed",
                                                  countOf: "disbursed",
                                                  reset: false);
                                            } else if (transactionTab ==
                                                "approved") {
                                              controller.fetchLoans(
                                                  status: "approved",
                                                  countOf: "approved",
                                                  reset: false);
                                            } else {
                                              print("in else cond");
                                            }
                                            // controller.initFetchData();
                                          }
                                        }
                                      }
                                      return true;
                                    },
                                    child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                1.2,
                                        child: (controller.response != null &&
                                                controller.response.length > 0)
                                            ? ListView.builder(
                                                physics:
                                                    ClampingScrollPhysics(),
                                                itemBuilder: (_, i) => ListTile(
                                                    title:
                                                        DoctorTransactionsCardScreen(
                                                            eachResponseItem:
                                                                controller
                                                                        .response[
                                                                    i])),
                                                itemCount:
                                                    controller.response.length,
                                              )
                                            : Center(
                                                child: FadeSlideTransition(
                                                  additionalOffset: 0.0,
                                                  animation:
                                                      _formElementAnimation,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 153 * fem,
                                                        height: 153 * fem,
                                                        child: Image.asset(
                                                            "assets/images/noTransactions.png"),
                                                      ),
                                                      Text(
                                                        "No Transaction Found",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'DM Sans',
                                                            color: AppColors
                                                                .primaryPurple,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )),
                                  )
                                  // DoctorTransactionsCardScreen(),
                                  // DoctorTransactionsCardScreen(),
                                  // DoctorTransactionsCardScreen(),
                                ],
                              ),
                            ))
                      ]),
                )),
          )),
    );
  }
}
