import 'package:CarePay/view_model/patientFlow/shareDoctorDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../components/fade_slide_transition.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';

class ShareDoctorDetails extends StatefulWidget {
  const ShareDoctorDetails({Key? key}) : super(key: key);

  @override
  State<ShareDoctorDetails> createState() => _ShareDoctorDetailsState();
}

class _ShareDoctorDetailsState extends State<ShareDoctorDetails>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyYourName = GlobalKey<FormState>();
  final _formKeyDoctorName = GlobalKey<FormState>();
  final _formKeyDoctorContact = GlobalKey<FormState>();
  final _formKeyLoanPurpose = GlobalKey<FormState>();
  final _formKeyLoanRequestAmount = GlobalKey<FormState>();
  final _formKeyMob = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // var fetchData = Provider.of<AddPatientController>(context, listen: false);
      // fetchData.initFetchData(context);
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
    final controller = Provider.of<ShareDoctorDetailsController>(context);
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
          controller.handleClear();
          return true;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                TextConstant.shareDoctorDetails,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16 * fem,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                        text: TextConstant.yourName,
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
                                    key: _formKeyYourName,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller: controller.nameController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyYourName.currentState!
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
                                          if (value == null || value.isEmpty) {
                                            return TextConstant.nameRequireddd;
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
                          SizedBox(height: 15),
                          FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 2 * space,
                            child: Container(
                              child: Text(
                                TextConstant.yourContactNumber,
                                style: TextStyle(
                                  // 'Work Sans',
                                  fontFamily: "DM Sans",
                                  // letterSpacing: 0.5,
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w400,
                                  height: 1.1725 * ffem / fem,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(height: 10),
                              FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: 2 * space,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Text(
                                    TextConstant.countryCode,
                                    style: TextStyle(
                                        fontSize: 14 * fem,
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                // group167cge (455:270)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
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
                                        // child: Text(
                                        //   TextConstant.yourContactNumber,
                                        //   style: TextStyle(
                                        //     // 'Work Sans',
                                        //     fontFamily: "DM Sans",
                                        //     letterSpacing: 0.5,
                                        //     fontSize: 16 * ffem,
                                        //     fontWeight: FontWeight.w400,
                                        //     height: 1.1725 * ffem / fem,
                                        //     color: AppColors.ff959fba,
                                        //   ),
                                        // ),
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
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 1.5 * fem),
                                          child: TextFormField(
                                            onChanged: (value) {
                                              if (value.length > 1) {
                                                _formKeyMob.currentState!
                                                    .validate();
                                                // // _formKeyPan.currentState!.validate();
                                              }
                                            },
                                            controller:
                                                controller.mobController,
                                            maxLength: 10,
                                            keyboardType: TextInputType.number,
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
                                                  TextConstant.enterMobile,
                                              // prefix: Text("+91"),
                                              // prefixText: TextConstant.countryCode,
                                              // prefixIcon: Text(
                                              //   TextConstant.countryCode,
                                              //   style: TextStyle(
                                              //       fontFamily: "Dm Sans",
                                              //       // backgroundColor: Colors.white,
                                              //       fontSize: 16 * ffem,
                                              //       fontWeight: FontWeight.w500,
                                              //       height: 2.35,
                                              //       color: Colors.black,
                                              //       letterSpacing: 0.5),
                                              // ),
                                              // prefixStyle: TextStyle(
                                              //     // 'Work Sans',
                                              //     fontFamily: "poppins",
                                              //     // backgroundColor: Colors.white,
                                              //     fontSize: 16 * ffem,
                                              //     fontWeight: FontWeight.w700,
                                              //     height: 1.1725 * ffem / fem,
                                              //     color: AppColors.black,
                                              //     letterSpacing: 0.5),
                                              hintStyle: TextStyle(
                                                  // 'Work Sans',
                                                  fontFamily: "DM Sans",
                                                  fontSize: 16 * fem,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.1725 * ffem / fem,
                                                  color: AppColors.black
                                                      .withOpacity(0.4),
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
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
                                        text: TextConstant.doctorName,
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
                                    key: _formKeyDoctorName,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        // maxLength: 10,
                                        controller:
                                            controller.doctorNameController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyDoctorName.currentState!
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
                                          if (value == null || value.isEmpty) {
                                            return TextConstant.nameRequireddd;
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
                                        text: TextConstant.doctorContact,
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
                                    key: _formKeyDoctorContact,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller:
                                            controller.doctorContactController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyDoctorContact.currentState!
                                                .validate();
                                          }
                                        },
                                        maxLength: 10,
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
                                          hintText: TextConstant.enterNumber,
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
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.enterMobilee;
                                          } else if (value.length < 10) {
                                            return TextConstant
                                                .validContactRequired;
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
                                    key: _formKeyLoanPurpose,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        controller:
                                            controller.purposeOfLoanController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyLoanPurpose.currentState!
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
                                          hintText: TextConstant.enterPurpose,
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
                                          if (value!.trim().isEmpty) {
                                            return TextConstant.purposerequired;
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
                                    key: _formKeyLoanRequestAmount,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: controller
                                            .loanRequestAmountController,
                                        onChanged: (value) {
                                          if (value.length > 1) {
                                            _formKeyLoanRequestAmount
                                                .currentState!
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
                                          hintText: TextConstant.requestAmount,
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
                                              if (_formKeyYourName
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyMob
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyDoctorName
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyLoanPurpose
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyLoanRequestAmount
                                                      .currentState!
                                                      .validate() &&
                                                  _formKeyDoctorContact
                                                      .currentState!
                                                      .validate()) {
                                                controller
                                                    .handleSubmition(context);
                                              } else {
                                                _formKeyYourName.currentState!
                                                    .validate();
                                                _formKeyMob.currentState!
                                                    .validate();
                                                _formKeyDoctorName.currentState!
                                                    .validate();
                                                _formKeyLoanPurpose
                                                    .currentState!
                                                    .validate();
                                                _formKeyLoanRequestAmount
                                                    .currentState!
                                                    .validate();
                                                _formKeyDoctorContact
                                                    .currentState!
                                                    .validate();
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
                                                        TextConstant.sendAdd,
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
                        ]),
                  )),
            )),
      ),
    );
  }
}
