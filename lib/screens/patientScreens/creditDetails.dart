import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/patientFlow/creditDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';

class CreditDetails extends StatefulWidget {
  const CreditDetails({super.key});

  @override
  State<CreditDetails> createState() => _CreditDetailsState();
}

class _CreditDetailsState extends State<CreditDetails>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyTreatmentName = GlobalKey<FormState>();
  final _formKeyFullName = GlobalKey<FormState>();
  final _formKeyClinicName = GlobalKey<FormState>();
  final _formKeyPurposeOfCredit = GlobalKey<FormState>();
  final _formKeyCreditAmount = GlobalKey<FormState>();

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   var fetchData =
    //       Provider.of<CreditDetailController>(context, listen: false);
    //   fetchData.initFetchData(context);
    // });
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
    final controller = Provider.of<CreditDetailController>(context);
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
              //       child: UploadBankStatementScreen()),
              // );

              return false;
            },
            child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: AppBar(
                  backgroundColor: AppColors.white,
                  elevation: 0,
                  centerTitle: false,
                  automaticallyImplyLeading: false,
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
                  leading: null,
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
                    padding: EdgeInsets.fromLTRB(
                        10 * fem, 10 * fem, 10 * fem, 0 * fem),
                    child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Container(
                            child: FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: space,
                                child: Text(
                                  TextConstant.creditDetails,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16 * fem),
                                )),
                          ),
                          Container(
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
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
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.creditAmount,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: "DM Sans",
                                          letterSpacing: 0.5,
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * ffem / fem,
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ),
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Form(
                                    key: _formKeyCreditAmount,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.clinicNameController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            _formKeyCreditAmount.currentState!
                                                .validate();
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1,
                                          fontFamily: 'DM Sans',
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.all(2 * fem),
                                          fillColor: AppColors.transparent,
                                          filled: true,
                                          hintText:
                                              TextConstant.enterCreditAmount,
                                          hintStyle: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black54,
                                              letterSpacing: 0.5),
                                          prefix: SizedBox(
                                              width: 9 * fem,
                                              height: 20 * fem,
                                              child: Image.asset(
                                                  'assets/images/₹.png')),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant
                                                .creditAmountRequired;
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
                          Container(
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
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
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.treatmentName,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: "DM Sans",
                                          letterSpacing: 0.5,
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * ffem / fem,
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ),
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Form(
                                    key: _formKeyTreatmentName,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.treatmentNameController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            _formKeyTreatmentName.currentState!
                                                .validate();
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1,
                                          fontFamily: 'DM Sans',
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.all(2 * fem),
                                          fillColor: AppColors.transparent,
                                          filled: true,
                                          hintText:
                                              TextConstant.enterTreatmentName,
                                          hintStyle: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black54,
                                              letterSpacing: 0.5),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant
                                                .treatmentNameRequired;
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
                          Container(
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
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
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.fullNameAsPerPan,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: "DM Sans",
                                          letterSpacing: 0.5,
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * ffem / fem,
                                          color:
                                              AppColors.black.withOpacity(0.4),
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
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.fullNameController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            _formKeyFullName.currentState!
                                                .validate();
                                          }
                                        },
                                        keyboardType: TextInputType.name,
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1,
                                          fontFamily: 'DM Sans',
                                        ),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              EdgeInsets.all(2 * fem),
                                          fillColor: AppColors.transparent,
                                          filled: true,
                                          hintText: TextConstant.enterFullName,
                                          hintStyle: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black54,
                                              letterSpacing: 0.5),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.enterFullNamee;
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
                          Container(
                            // group167cge (455:270)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 5 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
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
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.whatAreYouBorrow,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: "DM Sans",
                                          letterSpacing: 0.5,
                                          fontSize: 14 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * ffem / fem,
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ),
                                FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    additionalOffset: 2 * space,
                                    child: Column(
                                      children: [
                                        for (var item in controller.borrowFor)
                                          ListTile(
                                            visualDensity: VisualDensity(
                                                horizontal: -0, vertical: -3),
                                            minLeadingWidth: 0 * fem,
                                            contentPadding: EdgeInsets.all(0),
                                            minVerticalPadding: 0,
                                            horizontalTitleGap: 0,
                                            title: Text('${item.toString()}'),
                                            leading: Radio(
                                              activeColor:
                                                  AppColors.primaryPurple,
                                              value: item.toString(),
                                              groupValue: controller
                                                  .borrowForValue
                                                  .toString(),
                                              onChanged: (value) {
                                                controller.setBorrowFor(
                                                    value.toString());
                                                // setState(() {
                                                //   genderValue = value.toString();
                                                // });
                                              },
                                            ),
                                          ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ]))))));
  }
}
