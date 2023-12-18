import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/doctorFlow/addPatientController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';

class AddPatientScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPatientState();
  }
}

class AddPatientState extends State<AddPatientScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyClinicName = GlobalKey<FormState>();
  final _formKeyPatientName = GlobalKey<FormState>();
  final _formKeyPatientNumber = GlobalKey<FormState>();
  final _formKeyLoanPurpose = GlobalKey<FormState>();
  final _formKeyLoanRequestAmount = GlobalKey<FormState>();
  final _formKeyEmailId = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<AddPatientController>(context, listen: false);
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
    final controller = Provider.of<AddPatientController>(context);
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
          return true;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                TextConstant.addPatient,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              elevation: 1,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            body: Padding(
              padding:
                  EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 0 * fem),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                        text: TextConstant.clinicName,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyClinicName,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        enabled: false,
                                        enableInteractiveSelection: false,
                                        focusNode: FocusNode(),
                                        controller:
                                            controller.clinicNameController,

                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.enterName,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {},
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.patientName,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyPatientName,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.patientNameController,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            _formKeyPatientName.currentState!
                                                .validate();
                                          }
                                        },
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.enterName,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.nameRequireddd;
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.number,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyPatientNumber,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        maxLength: 10,
                                        controller:
                                            controller.patientNumberController,
                                        onChanged: (value) {
                                          if (value.length > 8) {
                                            _formKeyPatientNumber.currentState!
                                                .validate();
                                          }
                                        },
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.enterNumber,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            if (value!.trim().isEmpty) {
                                              return TextConstant
                                                  .requiredMobile;
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.email,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyEmailId,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.emailIdController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyEmailId.currentState!
                                                .validate();
                                          }
                                        },
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.enterEmail,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return TextConstant.enterEmaill;
                                          } else if (!RegExp(r'\S+@\S+\.\S+')
                                              .hasMatch(value)) {
                                            return TextConstant.validEmail;
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.purposeOfLoan,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyLoanPurpose,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.loanPurposeController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyLoanPurpose.currentState!
                                                .validate();
                                          }
                                        },
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.enterPurpose,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.purposerequired;
                                          } else if (value.length <= 1) {
                                            return TextConstant
                                                .purposeRequiredAtleast;
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.loanRequest,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                    key: _formKeyLoanRequestAmount,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controller
                                            .loanRequestAmountController,
                                        onChanged: (value) {
                                          // if (value.length > 1) {
                                          _formKeyLoanRequestAmount
                                              .currentState!
                                              .validate();
                                          // }
                                        },
                                        // maxLength: 10,
                                        // autofocus: true,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.5),
                                        decoration: InputDecoration(
                                          counterText: "",
                                          contentPadding:
                                              const EdgeInsets.all(15),
                                          fillColor: AppColors.ECEBFF,
                                          filled: true,
                                          hintText: TextConstant.requestAmount,
                                          hintStyle: TextStyle(
                                            color: AppColors.black
                                                .withOpacity(0.4),
                                            fontFamily: 'DM Sans',
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem),
                                              borderSide: BorderSide.none),
                                        ),
                                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.amountRequired;
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
                                    child: Text.rich(
                                        TextSpan(children: <InlineSpan>[
                                      TextSpan(
                                        text: TextConstant.loanEmi,
                                        style: TextStyle(
                                          // 'Work Sans',
                                          fontFamily: 'DM Sans',
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
                                              TextConstant.selectFromBelow,
                                              style: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.4),
                                                fontFamily: 'DM Sans',
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          value:
                                              controller.loanEmiDropdownValue,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium,
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          items: controller.loanEmiDropdown
                                              .map((data) {
                                            return DropdownMenuItem(
                                                value: data,
                                                child: Row(
                                                  children: [
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
                                            controller
                                                .setLoanEmi(value.toString());
                                          },
                                        )),
                                  ),
                                ),
                                if (controller.loanEmiDropdownError) ...[
                                  FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      // additionalOffset: fem,
                                      additionalOffset: 0.0,
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(12 * fem,
                                            5 * fem, 0 * fem, 0 * fem),
                                        child: Text(
                                          TextConstant.selectLoanEmi,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'DM Sans',
                                              color: AppColors.redError,
                                              fontSize: 12 * fem),
                                        ),
                                      ))
                                ],
                              ],
                            ),
                          ),
                          Container(

                              // group167cge (455:270)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 20 * fem, 0 * fem, 20 * fem),
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
                                              if (_formKeyPatientName.currentState!.validate() &&
                                                  _formKeyPatientNumber
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyLoanPurpose
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyLoanRequestAmount
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyEmailId.currentState!
                                                      .validate()) {
                                                controller
                                                    .handleSubmition(context);
                                              } else {
                                                _formKeyPatientName
                                                    .currentState!
                                                    .validate();
                                                _formKeyPatientNumber
                                                    .currentState!
                                                    .validate();
                                                _formKeyLoanPurpose
                                                    .currentState!
                                                    .validate();
                                                _formKeyLoanRequestAmount
                                                    .currentState!
                                                    .validate();
                                                _formKeyEmailId.currentState!
                                                    .validate();
                                                if (controller
                                                        .loanEmiDropdownValue
                                                        .toString() ==
                                                    controller
                                                        .loanEmiDropdown[0]
                                                        .toString()) {
                                                  controller
                                                      .setLoanEmiError(true);
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                            .center,
                                                    children: [
                                                      Text(
                                                        TextConstant
                                                            .sendRequest,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          // 'Work Sans',
                                                          fontSize: 14 * fem,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 1.1725 *
                                                              fem /
                                                              fem,
                                                          color:
                                                              AppColors.white,
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
                                  ))),
                        ]),
                  )),
            )),
      ),
    );
  }
}
