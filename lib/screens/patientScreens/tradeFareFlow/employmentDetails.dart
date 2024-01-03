import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/patientFlow/employementDetailCotroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import '../../../res/textConstant.dart';
import 'addressDetail.dart';

class EmploymentDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmploymentDetailState();
  }
}

class EmploymentDetailState extends State<EmploymentDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyMonthlyIncome = GlobalKey<FormState>();
  final _formKeyMonthlyFamilyIncome = GlobalKey<FormState>();
  final _formKeyBuisnessName = GlobalKey<FormState>();
  final _formKeyCurrentCompanyAdd1 = GlobalKey<FormState>();
  final _formKeyCurrentCompanyAdd2 = GlobalKey<FormState>();
  final _formKeyCurrentCompanyPincode = GlobalKey<FormState>();
  final _formKeyIndustry = GlobalKey<FormState>();
  final _formKeySalaryDate = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var fetchData =
          Provider.of<EmploymentDetailController>(context, listen: false);
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
    // controller.scrollController.animateTo(0.0,
    //     duration: Duration(milliseconds: 500), curve: Curves.ease);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<EmploymentDetailController>(context);
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
                child: AddressDetailScreen()),
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
                      child: AddressDetailScreen()),
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
                      height: 4 * fem,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: AppColors.tertiaryOrange,
                              borderRadius: BorderRadius.circular(4 * fem)),
                          padding:
                              EdgeInsets.fromLTRB(0 * fem, 15, 0 * fem, 15),
                          child: Text(TextConstant.pleaseVerify,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.primaryOrange))),
                    ),
                    SizedBox(
                      width: 1,
                      height: 25 * fem,
                    ),
                    Container(
                      child: FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: Text(
                            TextConstant.emplyomentDetails,
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
                          0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4 * fem),
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
                                  0 * fem, 10 * fem, 0 * fem, 5 * fem),
                              child: Text.rich(TextSpan(children: <InlineSpan>[
                                TextSpan(
                                  text: TextConstant.selectEmploymentType,
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
                              ])),
                            ),
                          ),
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            // additionalOffset: fem,
                            additionalOffset: 0.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.ECEBFF,
                                  borderRadius: BorderRadius.circular(4 * fem)),
                              child: ButtonTheme(
                                  buttonColor: AppColors.ECEBFF,
                                  alignedDropdown: true,
                                  child: DropdownButton(
                                    underline: SizedBox(),
                                    dropdownColor: AppColors.ECEBFF,
                                    icon: const Icon(Icons.keyboard_arrow_down),
                                    isExpanded: true,
                                    elevation: 2,
                                    hint: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(TextConstant.selectFromBelow),
                                    ),
                                    value:
                                        controller.employmentTypeDropdownValue,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    borderRadius:
                                        BorderRadius.circular(4 * fem),
                                    items: controller.employmentTypeDropDown
                                        .map((data) {
                                      return DropdownMenuItem(
                                          value: data,
                                          child: Row(
                                            // mainAxisAlignment:
                                            // bankDropDownTagImageItems[
                                            // '${items}']
                                            //     .toString()
                                            //     .isEmpty
                                            //     ? MainAxisAlignment.center
                                            //     : MainAxisAlignment.start,
                                            children: [
                                              // if (data.toString().isNotEmpty) ...[
                                              //   SizedBox(
                                              //     width: 30,
                                              //     child: Image.asset(data.productImage),
                                              //   )
                                              // ],
                                              // SizedBox(
                                              //   width: 10,
                                              // ),
                                              Expanded(
                                                child: Text(
                                                  data,
                                                  style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 15),
                                                ),
                                              ),
                                            ],
                                          ));
                                    }).toList(),
                                    onChanged: (value) {
                                      controller
                                          .setEmployementTypeDropdownValue(
                                              value.toString());
                                      // print(staffDropdownvalue);
                                    },
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible:
                          controller.employmentTypeDropdownValue == "Salaried",
                      child: Container(
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4 * fem),
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
                                    0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.selectCurrentEmployer,
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
                                ])),
                              ),
                            ),
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              // additionalOffset: fem,
                              additionalOffset: 0.0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.ECEBFF,
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)),
                                child: ButtonTheme(
                                    buttonColor: AppColors.ECEBFF,
                                    alignedDropdown: true,
                                    child: DropdownButton(
                                      underline: SizedBox(),
                                      dropdownColor: AppColors.ECEBFF,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_down),
                                      isExpanded: true,
                                      elevation: 2,
                                      hint: Align(
                                        alignment: Alignment.centerLeft,
                                        child:
                                            Text(TextConstant.selectFromBelow),
                                      ),
                                      value: controller
                                          .currentEmployerDropdownValue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      borderRadius:
                                          BorderRadius.circular(4 * fem),
                                      items: controller.currentEmployerDropDown
                                          .map((data) {
                                        return DropdownMenuItem(
                                            value: data,
                                            child: Row(
                                              // mainAxisAlignment:
                                              // bankDropDownTagImageItems[
                                              // '${items}']
                                              //     .toString()
                                              //     .isEmpty
                                              //     ? MainAxisAlignment.center
                                              //     : MainAxisAlignment.start,
                                              children: [
                                                // if (data.toString().isNotEmpty) ...[
                                                //   SizedBox(
                                                //     width: 30,
                                                //     child: Image.asset(data.productImage),
                                                //   )
                                                // ],
                                                // SizedBox(
                                                //   width: 10,
                                                // ),
                                                Expanded(
                                                  child: Text(
                                                    data,
                                                    style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        // controller
                                        //     .setEmployementTypeDropdownValue(
                                        //         value.toString());
                                        // print(staffDropdownvalue);
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                        visible: controller.employmentTypeDropdownValue ==
                            "Self-employed",
                        child: Column(
                          children: [
                            Container(
                              // group167cge (455:270)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 10 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4 * fem),
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
                                          0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.buisnessType,
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
                                      ])),
                                    ),
                                  ),
                                  FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    // additionalOffset: fem,
                                    additionalOffset: 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.ECEBFF,
                                          borderRadius:
                                              BorderRadius.circular(4 * fem)),
                                      child: ButtonTheme(
                                          buttonColor: AppColors.ECEBFF,
                                          alignedDropdown: true,
                                          child: DropdownButton(
                                            underline: SizedBox(),
                                            dropdownColor: AppColors.ECEBFF,
                                            icon: const Icon(
                                                Icons.keyboard_arrow_down),
                                            isExpanded: true,
                                            elevation: 2,
                                            hint: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  TextConstant.selectFromBelow),
                                            ),
                                            value: controller
                                                .buisnessTypeDropdownValue,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium,
                                            borderRadius:
                                                BorderRadius.circular(4 * fem),
                                            items: controller
                                                .buisnessTypeDropDown
                                                .map((data) {
                                              return DropdownMenuItem(
                                                  value: data,
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    // bankDropDownTagImageItems[
                                                    // '${items}']
                                                    //     .toString()
                                                    //     .isEmpty
                                                    //     ? MainAxisAlignment.center
                                                    //     : MainAxisAlignment.start,
                                                    children: [
                                                      // if (data.toString().isNotEmpty) ...[
                                                      //   SizedBox(
                                                      //     width: 30,
                                                      //     child: Image.asset(data.productImage),
                                                      //   )
                                                      // ],
                                                      // SizedBox(
                                                      //   width: 10,
                                                      // ),
                                                      Expanded(
                                                        child: Text(
                                                          data,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontSize: 15),
                                                        ),
                                                      ),
                                                    ],
                                                  ));
                                            }).toList(),
                                            onChanged: (value) {
                                              // controller
                                              //     .setEmployementTypeDropdownValue(
                                              //         value.toString());
                                              // print(staffDropdownvalue);
                                            },
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // group167cge (455:270)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 10 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4 * fem),
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
                                          0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.buisnessName,
                                          style: TextStyle(
                                            // 'Work Sans',
                                            fontFamily: "DM Sans",
                                            letterSpacing: 0.5,
                                            fontSize: 14 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.1725 * ffem / fem,
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
                                      key: _formKeyBuisnessName,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 1.5 * fem),
                                        child: TextFormField(
                                          keyboardType: TextInputType.name,
                                          controller:
                                              controller.buisnessNameController,
                                          onChanged: (value) {
                                            if (value.length > 1) {
                                              _formKeyBuisnessName.currentState!
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
                                                const EdgeInsets.all(15),
                                            fillColor: AppColors.ECEBFF,
                                            filled: true,
                                            hintText: TextConstant.enterName,
                                            hintStyle: TextStyle(
                                                // 'Work Sans',
                                                fontFamily: "DM Sans",
                                                fontSize: 14 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.1725 * ffem / fem,
                                                color: Colors.black54,
                                                letterSpacing: 0.5),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                                borderSide: BorderSide.none),
                                          ),
                                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return TextConstant
                                                  .nameRequireddd;
                                            } else if (value.length < 2) {
                                              return TextConstant.invalidName;
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
                          ],
                        )),
                    Container(
                      // group167cge (455:270)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4 * fem),
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
                                  0 * fem, 10 * fem, 0 * fem, 5 * fem),
                              child: Text.rich(TextSpan(children: <InlineSpan>[
                                TextSpan(
                                  text: TextConstant.monthly,
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
                              ])),
                            ),
                          ),
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 2 * space,
                            child: Form(
                              key: _formKeyMonthlyIncome,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      controller.monthlyIncomeController,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      _formKeyMonthlyIncome.currentState!
                                          .validate();
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
                                    contentPadding: const EdgeInsets.all(15),
                                    fillColor: AppColors.ECEBFF,
                                    filled: true,
                                    hintText: TextConstant.enterYour,
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
                                            BorderRadius.circular(4 * fem),
                                        borderSide: BorderSide.none),
                                  ),
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return TextConstant.monthlyIncome;
                                    } else {
                                      return null;
                                    }
                                  },
                                  // onChanged: (value){
                                  //   setState(() {
                                  //     otpSentStatus = false;
                                  //   });
                                  // },
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
                          0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4 * fem),
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
                                  0 * fem, 10 * fem, 0 * fem, 5 * fem),
                              child: Text.rich(TextSpan(children: <InlineSpan>[
                                TextSpan(
                                  text: TextConstant.monthlyIncomeOptional,
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
                              ])),
                            ),
                          ),
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 2 * space,
                            child: Form(
                              key: _formKeyMonthlyFamilyIncome,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller:
                                      controller.monthlyFamilyIncomeController,
                                  // onChanged: (value) {
                                  //   // if (value.length > 8) {
                                  //   //   _formKeyPan.currentState!.validate();
                                  //   // }
                                  // },
                                  // maxLength: 10,
                                  // autofocus: true,
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  decoration: InputDecoration(
                                    counterText: "",
                                    contentPadding: const EdgeInsets.all(15),
                                    fillColor: AppColors.ECEBFF,
                                    filled: true,
                                    hintText: TextConstant.familyIncome,
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
                                            BorderRadius.circular(4 * fem),
                                        borderSide: BorderSide.none),
                                  ),
                                  // autovalidateMode: AutovalidateMode.onUserInteraction,
                                  // validator: (value) {
                                  //   if (value!.trim().isEmpty) {
                                  //     return TextConstant.familyIncomeRequired;
                                  //   } else {
                                  //     return null;
                                  //   }
                                  // },
                                  // onChanged: (value){
                                  //   setState(() {
                                  //     otpSentStatus = false;
                                  //   });
                                  // },
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
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        // primary: AppColors.transparent,
                                        // onSurface: AppColors.transparent,
                                        // shadowColor: AppColors.transparent,
                                        primary: controller.isEmpty()
                                            ? AppColors.primaryPurple
                                            : AppColors.primaryPurple
                                                .withOpacity(0.4),
                                      ),
                                      onPressed: () {},
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
                                                  TextConstant.confirm,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    // 'Work Sans',
                                                    fontSize: 14 * fem,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.1725 * fem / fem,
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
                  ]))),
        ),
      ),
    );
  }

  Widget _textFieldOTP(TextEditingController fieldOne, {bool? first, last}) {
    //  WidgetsBinding.instance.addPostFrameCallback((_) {
    var controller = Provider.of<EmploymentDetailController>(context);

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
          autofocus: false,
          controller: fieldOne,

          // focusNode: fieldOne == _fieldOne ? otpFirstFieldFocus :null,
          onChanged: (value) {
            if (value.length == 2 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
            controller.checkValidExp();
          },
          showCursor: true,
          readOnly: false,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, fontFamily: "DM Sans"),
          keyboardType: TextInputType.number,
          maxLength: 2,

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
