import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/uploadBankStatement.dart';
import 'package:CarePay/view_model/patientFlow/bankDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class BAnkStatementCollection extends StatefulWidget {
  const BAnkStatementCollection({Key? key}) : super(key: key);

  @override
  State<BAnkStatementCollection> createState() =>
      _BAnkStatementCollectionState();
}

class _BAnkStatementCollectionState extends State<BAnkStatementCollection>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Navigator.pushReplacement(
          //   context,
          //   PageTransition(
          //       type: PageTransitionType.rightToLeftWithFade,
          //       child: NewBankDetails()),
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
                  //       child: NewBankDetails()),
                  // );
                },
              ),

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
                      SizedBox(height: 15 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Text(TextConstant.bankStatementCollection,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                                fontSize: 16 * fem,
                                color: AppColors.black)),
                      ),
                      SizedBox(height: 15 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Text(TextConstant.toVerifyYour,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans',
                                fontSize: 14 * fem,
                                color: AppColors.black)),
                      ),
                      SizedBox(height: 18 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: const Center(
                          child: Image(
                              image: AssetImage(
                                  'assets/images/icIncomeVerification.png')),
                        ),
                      ),
                      SizedBox(height: 25 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Your bank:",
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text("Your bank acc no:",
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
                                  Text(
                                      controller.bankNameController.text
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                  SizedBox(height: 8),
                                  Text(
                                      controller.accountNumberController.text
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans',
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.black
                                              .withOpacity(0.8))),
                                ]),
                          ],
                        ),
                      ),
                      SizedBox(height: 15 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Text(TextConstant.selectOptionTo,
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans',
                                fontSize: 14 * fem,
                                color: AppColors.black)),
                      ),
                      SizedBox(height: 15 * fem),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   PageTransition(
                                //       type: PageTransitionType.rightToLeftWithFade,
                                //       child: CreditDetailScreen()),
                                //   // BankDetailScreen()),
                                // );
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.ECEBFF.withOpacity(0.6),
                                      borderRadius:
                                          BorderRadius.circular(4 * fem)),
                                  padding: EdgeInsets.fromLTRB(
                                      10 * fem, 16 * fem, 10 * fem, 10 * fem),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              TextConstant
                                                  .proceedWithCompletelyDigital,
                                              style: TextStyle(
                                                  fontSize: 14 * fem,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.black
                                                      .withOpacity(0.3))),
                                          SizedBox(
                                            width: 1,
                                            height: 5 * fem,
                                          ),
                                          Row(children: [
                                            Container(
                                              width: 18 * fem,
                                              height: 18 * fem,
                                              // padding: EdgeInsets.only(top: 25),
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/images/lightning.png'),
                                                  opacity:
                                                      const AlwaysStoppedAnimation(
                                                          .5)),
                                            ),
                                            SizedBox(
                                              width: 4 * fem,
                                              height: 1,
                                            ),
                                            Text(TextConstant.faster,
                                                style: TextStyle(
                                                    fontSize: 12 * fem,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryGreen,
                                                    fontStyle:
                                                        FontStyle.italic))
                                          ])
                                        ],
                                      ),
                                      // Icon(
                                      //   Icons.arrow_forward_ios,
                                      //   size: 30,
                                      //   color: AppColors.primaryPurple
                                      //       .withOpacity(0.4),
                                      // )
                                      Icon(
                                        Icons
                                            .no_encryption_gmailerrorred_outlined,
                                        size: 25,
                                        color: AppColors.primaryPurple
                                            .withOpacity(0.4),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(height: 12 * fem),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: UploadBankStatementScreen()),
                                  // BankDetailScreen()),
                                );
                              },
                              child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: AppColors.ECEBFF,
                                      borderRadius:
                                          BorderRadius.circular(4 * fem)),
                                  padding: EdgeInsets.fromLTRB(
                                      10 * fem, 16 * fem, 10 * fem, 16 * fem),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(TextConstant.uploadBankAccount,
                                          style: TextStyle(
                                              fontSize: 14 * fem,
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.black)),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 30,
                                        color: AppColors.primaryPurple
                                            .withOpacity(0.4),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            )),
      ),
    );
  }
}
