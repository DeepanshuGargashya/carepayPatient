import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/patientFlow/bankDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class SuccessfullyFetched extends StatefulWidget {
  const SuccessfullyFetched({Key? key}) : super(key: key);

  @override
  State<SuccessfullyFetched> createState() => _SuccessfullyFetchedState();
}

class _SuccessfullyFetchedState extends State<SuccessfullyFetched>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<BankDetailController>(context, listen: false);
      // fetchData.getRpdBankDetails(context);
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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              leadingWidth: 0 * fem,
              // centerTitle: false,
              // leadingWidth: 0,
              // titleSpacing: 0,
              title: Text(
                TextConstant.loanApplicationn,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            body: Padding(
              padding:
                  EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 0 * fem),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  FadeSlideTransition(
                    additionalOffset: space,
                    animation: _formElementAnimation,
                    child: Container(
                      // width: 32 * fem,
                      // height: 32 * fem,
                      // padding: EdgeInsets.only(top: 25),
                      child: Image(
                          image: AssetImage('assets/images/received.png')),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 15 * fem, 0 * fem, 15 * fem),
                    child: FadeSlideTransition(
                      additionalOffset: space,
                      animation: _formElementAnimation,
                      child: Text('Successfully fetched your bank details.',
                          style: TextStyle(
                              fontSize: 16 * fem,
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryPurple)),
                    ),
                  ),
                  FadeSlideTransition(
                    additionalOffset: space,
                    animation: _formElementAnimation,
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColors.ECEBFF,
                            borderRadius: BorderRadius.circular(4 * fem)),
                        padding: EdgeInsets.fromLTRB(
                            30 * fem, 15 * fem, 10 * fem, 15 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Bank:",
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text("Account number:",
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text("IFSC:",
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                ]),
                            SizedBox(width: 15 * fem),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(controller.bankName.toString(),
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text(controller.accountNumber.toString(),
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text(controller.IFSCCode.toString(),
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color:
                                              AppColors.black.withOpacity(0.8)))
                                ]),
                          ],
                        )),
                  ),
                  SizedBox(
                    width: 1,
                    height: 20 * fem,
                  ),
                  FadeSlideTransition(
                    additionalOffset: space,
                    animation: _formElementAnimation,
                    child: Container(
                      width: double.infinity,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 20 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        0, 15 * fem, 0, 15 * fem),
                                    child: Text(
                                      TextConstant.proceedWithThis,
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14 * fem),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller
                                        .handleSuccessfullyfetchedTemp(context);
                                    // controller
                                    //     .handleProceedThisSubmition(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: AppColors.primaryPurple,

                                      // fixedSize: Size(380, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 15 * fem),
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 10 * fem, 0 * fem, 0 * fem),
                    child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: FadeSlideTransition(
                            additionalOffset: space,
                            animation: _formElementAnimation,
                            child: Center(
                                child: Text('Change account',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 14 * fem,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.black
                                            .withOpacity(0.8)))))),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
