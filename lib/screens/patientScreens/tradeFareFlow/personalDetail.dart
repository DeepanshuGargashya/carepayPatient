import 'package:CarePay/view_model/patientFlow/personalDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import '../../../res/color.dart';
import '../../../res/textConstant.dart';

class PersonalDetailScreen extends StatefulWidget {
  // var mobile = "";
  PersonalDetailScreen();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PersonalDetailState();
  }
}

class PersonalDetailState extends State<PersonalDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  bool isButtonEnabled = false;

  final _formKeyPan = GlobalKey<FormState>();
  final _formKeyOwnerName = GlobalKey<FormState>();
  final _formKeyEmail = GlobalKey<FormState>();
  final _formKeyAltMob = GlobalKey<FormState>();
  final _formKeyrefMob = GlobalKey<FormState>();
  final _formKeyDob = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<PersonalDetailController>(context, listen: false);
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
    final controller = Provider.of<PersonalDetailController>(context);
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
          // async {
          //   Navigator.pushReplacement(
          //     context,
          //     PageTransition(
          //         type: PageTransitionType.rightToLeftWithFade,
          //         child: BankDetailScreen()),
          //   );

          return false;
        },
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              centerTitle: false,
              title: Text(
                TextConstant.loanApplicationn,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              // centerTitle: false,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.black,
                  )),
              automaticallyImplyLeading: true,
              elevation: 0,
              leadingWidth: 25 * fem,
              // backgroundColor: AppColors.white,
              // title: Column(
              //   children: [
              //     SizedBox(height: 14 * fem),
              // Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              //   // SizedBox(height: 7 * fem),
              //   Container(
              //     width: 143 * fem,
              //     height: 61 * fem,
              //     // padding: EdgeInsets.only(top: 25),
              //     child: Image(
              //         image: AssetImage(
              //       'assets/images/carePayLogo.png',
              //     )),
              //   ),
              // ]),
              // ],
              // ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(15.0 * fem),
                child: Container(
                  // padding: EdgeInsets.only(top: 15),
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: new LinearPercentIndicator(
                    barRadius: Radius.circular(10 * fem),
                    backgroundColor: AppColors.tertiaryOrange,
                    width: MediaQuery.of(context).size.width,
                    lineHeight: 8 * fem,
                    percent: 0.33,
                    progressColor: AppColors.primaryPurple,
                  ),
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
                      FadeSlideTransition(
                        additionalOffset: space,
                        animation: _formElementAnimation,
                        child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColors.tertiaryOrange,
                                borderRadius: BorderRadius.circular(4 * fem)),
                            padding:
                                EdgeInsets.fromLTRB(0 * fem, 15, 0 * fem, 15),
                            child: Text(TextConstant.please,
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
                              TextConstant.personalll,
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
                                    text: TextConstant.panNo,
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
                                key: _formKeyPan,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: controller.panController,
                                    onChanged: (value) {
                                      if (value.length > 8) {
                                        _formKeyPan.currentState!.validate();
                                      }
                                      controller.panController.value =
                                          TextEditingValue(
                                              text: value.toUpperCase(),
                                              selection: controller
                                                  .panController.selection);
                                    },
                                    maxLength: 10,
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
                                      hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans'),
                                      hintText: TextConstant.enterPan,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none),
                                    ),
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TextConstant.enterPann;
                                      } else if (value.length < 10 ||
                                          value.length > 10) {
                                        print(value.length);
                                        return TextConstant.enterValidPan;
                                      } else if (!RegExp(
                                              r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$')
                                          .hasMatch(value.toUpperCase())) {
                                        print(value);
                                        return TextConstant.enterValidPan;
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
                            0 * fem, 10 * fem, 0 * fem, 10 * fem),
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
                                    text: TextConstant.gender,
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
                                child: Column(
                                  children: [
                                    for (var item in controller.genders) ...[
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -0, vertical: -3),
                                        minLeadingWidth: 0 * fem,
                                        contentPadding: EdgeInsets.all(0),
                                        minVerticalPadding: 0,
                                        horizontalTitleGap: 0,
                                        title: Text('${item.toString()}'),
                                        leading: Radio(
                                          activeColor: AppColors.primaryPurple,
                                          value: item.toString(),
                                          groupValue:
                                              controller.genderValue.toString(),
                                          onChanged: (value) {
                                            controller.setGenderValue(
                                                value.toString());
                                            // setState(() {
                                            //   genderValue = value.toString();
                                            // });
                                          },
                                        ),
                                      ),
                                    ]
                                  ],
                                )),
                          ],
                        ),
                      ),

                      if (controller.genderError) ...[
                        Text('     Please select gender',
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.redError,
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.w400)),
                      ],
                      SizedBox(height: 10),
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
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.email,
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
                                key: _formKeyEmail,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 10 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: controller.emailController,
                                    onChanged: (value) {
                                      if (value.length > 1) {
                                        _formKeyEmail.currentState!.validate();
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
                                      hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans'),
                                      hintText: TextConstant.enterEmail,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
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
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 10 * fem),
                        child: FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.dateOfBirth,
                                    style: TextStyle(
                                      color: AppColors.black,
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Form(
                                      key: _formKeyDob,
                                      child: TextFormField(
                                        controller: controller.dobController,
                                        // enabled: false,
                                        keyboardType: TextInputType.none,
                                        decoration: InputDecoration(
                                            errorStyle: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors
                                                  .red, // or any other color
                                            ),
                                            suffixIcon: Icon(
                                                Icons.calendar_month_outlined,
                                                color: AppColors.primaryPurple),
                                            fillColor: AppColors.ECEBFF,
                                            filled: true,
                                            hintStyle: TextStyle(
                                                color: AppColors.black
                                                    .withOpacity(0.4),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14 * fem,
                                                fontFamily: 'DM Sans'),
                                            hintText:
                                                TextConstant.enterDateOfBirth,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        4 * fem),
                                                borderSide: BorderSide.none)),
                                        onTap: () async {
                                          var res = await controller
                                              .showDatePickerr(context);
                                          if (res) {
                                            _formKeyDob.currentState!
                                                .validate();
                                          }
                                        },
                                        validator: (value) {
                                          print(value);
                                          if (value == null || value.isEmpty) {
                                            return TextConstant
                                                .enterDateOfBirth;
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   // group167cge (455:270)
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 15 * fem, 0 * fem, 5 * fem),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4* fem),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         // additionalOffset: fem,
                      //         additionalOffset: 0.0,
                      //         child: Container(
                      //           // emailidwU2 (455:267)
                      //           margin: EdgeInsets.fromLTRB(
                      //               0 * fem, 0 * fem, 0 * fem, 3 * fem),
                      //           child: Text(
                      //             TextConstant.dateOfBirth,
                      //             style: TextStyle(
                      //               // 'Work Sans',
                      //               fontFamily: "DM Sans",
                      //               letterSpacing: 0.5,
                      //               fontSize: 14 * ffem,
                      //               fontWeight: FontWeight.w400,
                      //               height: 1.1725 * ffem / fem,
                      //               color: AppColors.black,
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         additionalOffset: 2 * space,
                      //         child: Form(
                      //           key: _formKeyDob,
                      //           child: Container(
                      //             margin: EdgeInsets.fromLTRB(
                      //                 0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                      //             child: TextFormField(
                      //               controller: controller.dobController,
                      //               keyboardType: TextInputType.none,
                      //               focusNode: FocusNode(),
                      //               onTap: () {
                      //                 controller.selectDate(context, "birth");
                      //               },
                      //               // maxLength: 10,
                      //               // autofocus: true,
                      //               style:
                      //                   const TextStyle(fontSize: 16, height: 1.5),
                      //               onChanged: (value) {
                      //                 _formKeyDob.currentState!.validate();
                      //               },
                      //               decoration: InputDecoration(
                      //                 counterText: "",
                      //                 contentPadding: const EdgeInsets.all(15),
                      //                 fillColor: AppColors.ECEBFF,
                      //                 filled: true,
                      //                 suffixIcon:
                      //                     Icon(Icons.calendar_month_outlined),
                      //                hintStyle: TextStyle(color: AppColors.black.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14*fem,fontFamily: 'DM Sans'),hintText: TextConstant.enterDateOfBirth,
                      //                 hintStyle: TextStyle(
                      //                     // 'Work Sans',
                      //                     fontFamily: "DM Sans",
                      //                     fontSize: 13 * ffem,
                      //                     fontWeight: FontWeight.w400,
                      //                     height: 1.1725 * ffem / fem,
                      //                     color: AppColors.black54,
                      //                     letterSpacing: 0.5),
                      //                 border: OutlineInputBorder(
                      //                     borderRadius: BorderRadius.circular(4* fem),
                      //                     borderSide: BorderSide.none),
                      //               ),
                      //               // autovalidateMode: AutovalidateMode.onUserInteraction,
                      //               validator: (value) {
                      //                 if (value!.trim().isEmpty) {
                      //                   return TextConstant.dobRequired;
                      //                 } else {
                      //                   return null;
                      //                 }
                      //               },
                      //               // onChanged: (value){
                      //               //   setState(() {
                      //               //     otpSentStatus = false;
                      //               //   });
                      //               // },
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      Container(
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 10 * fem, 0 * fem, 10 * fem),
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
                                    text: TextConstant.isMarried,
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
                                child: Column(
                                  children: [
                                    for (var item
                                        in controller.isMarriedOptions) ...[
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -0, vertical: -3),
                                        minLeadingWidth: 0 * fem,
                                        contentPadding: EdgeInsets.all(0),
                                        minVerticalPadding: 0,
                                        horizontalTitleGap: 0,
                                        title: Text('${item.toString()}'),
                                        leading: Radio(
                                          activeColor: AppColors.primaryPurple,
                                          value: item.toString(),
                                          groupValue: controller.isMarriedValue
                                              .toString(),
                                          onChanged: (value) {
                                            controller.setIsMarriedValue(
                                                value.toString());
                                            // setState(() {
                                            //   genderValue = value.toString();
                                            // });
                                          },
                                        ),
                                      ),
                                    ]
                                  ],
                                )),
                          ],
                        ),
                      ),

                      if (controller.isMarriedError) ...[
                        Text('     Please select above field',
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.redError,
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.w400)),
                      ],

                      Container(
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 15 * fem, 0 * fem, 10 * fem),
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
                                    0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                child: Text(
                                  TextConstant.alternate,
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
                              ),
                            ),
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: 2 * space,
                              child: Form(
                                key: _formKeyAltMob,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: controller.altMobController,
                                    maxLength: 10,
                                    keyboardType: TextInputType.number,
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

                                      // isDense: true,
                                      // floatingLabelBehavior:FloatingLabelBehavior.always,
                                      // labelText: 'Email',
                                      hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans'),
                                      hintText: TextConstant.enterMobileNumber,
                                      // prefix: Text("+91"),
                                      // prefixText: TextConstant.countryCode,
                                      // prefixStyle: TextStyle(
                                      //     // 'Work Sans',
                                      //     fontFamily: "DM Sans",
                                      //     // backgroundColor: Colors.white,
                                      //     fontSize: 16 * ffem,
                                      //     fontWeight: FontWeight.w700,
                                      //     height: 1.1725 * ffem / fem,
                                      //     color: AppColors.black,
                                      //     letterSpacing: 0.5),

                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none),
                                      //hintStyle: TextStyle(color: AppColors.black.withOpacity(0.4),fontWeight: FontWeight.w400,fontSize: 14*fem,fontFamily: 'DM Sans'),hintText: '**********',
                                    ),
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return TextConstant.requiredMobile;
                                      } else if (value.length < 10) {
                                        return TextConstant
                                            .enterValidMobileNumber;
                                      } else if (RegExp(r'^[1-9]{1}[0-9]{9}$')
                                          .hasMatch(value)) {
                                        return null;
                                      }
                                      return TextConstant.mobileNumberInvalid;
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
                              0 * fem, 15 * fem, 0 * fem, 0 * fem),
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
                                          0 * fem, 0 * fem, 0 * fem, 3 * fem),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            TextConstant.referenceText,
                                            style: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              letterSpacing: 0.5,
                                              fontSize: 14 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 1,
                                            height: 10 * fem,
                                          ),
                                          Text(
                                            TextConstant.relationNote,
                                            style: TextStyle(
                                              // 'Work Sans',
                                              fontFamily: "DM Sans",
                                              letterSpacing: 0.5,
                                              fontSize: 12 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 20 * fem, 0 * fem, 5 * fem),
                                    child: Text(
                                      TextConstant.provideContact,
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
                                FadeSlideTransition(
                                  animation: _formElementAnimation,
                                  additionalOffset: 2 * space,
                                  child: Form(
                                    key: _formKeyrefMob,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 5 * fem, 0 * fem, 1.5 * fem),
                                      child: TextFormField(
                                        onChanged: (value) {
                                          if (value.length > 8) {
                                            _formKeyrefMob.currentState!
                                                .validate();
                                            // // _formKeyPan.currentState!.validate();
                                          }
                                        },
                                        controller: controller.refMobController,
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
                                              TextConstant.enterMobileNumber,
                                          prefixIcon: Container(
                                            // Adjust the width and height according to your design
                                            width: 40 * fem,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "+91",
                                              style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 14 * fem,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.5),
                                            ),
                                          ),
                                          // prefixText: "+91",
                                          prefixStyle: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14 * fem),
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
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.1725 * ffem / fem,
                                              color: AppColors.black54,
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
                                            return TextConstant.requiredMobile;
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
                              ])),

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
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.ownerNameTitle,
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
                                key: _formKeyOwnerName,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: controller.ownerNameController,
                                    onChanged: (value) {
                                      if (value.length > 2) {
                                        _formKeyOwnerName.currentState!
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
                                      hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14 * fem,
                                          fontFamily: 'DM Sans'),
                                      hintText: TextConstant.ownerNameHint,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none),
                                    ),
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TextConstant.enterFullNamee;
                                      } else if (value.length < 2) {
                                        return TextConstant.invalidName;
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
                                    0 * fem, 10 * fem, 0 * fem, 10 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.relationWithPhone,
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
                                      value: controller.relationValue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      borderRadius:
                                          BorderRadius.circular(4 * fem),
                                      items: controller.relations.map((data) {
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
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        controller
                                            .setRelations(value.toString());
                                      },
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (controller.relationError) ...[
                        FadeSlideTransition(
                            animation: _formElementAnimation,
                            // additionalOffset: fem,
                            additionalOffset: 0.0,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(
                                  12 * fem, 5 * fem, 0 * fem, 0 * fem),
                              child: Text(
                                TextConstant.selectRelation,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'DM Sans',
                                    color: AppColors.redError,
                                    fontSize: 12 * fem),
                              ),
                            ))
                      ],

                      Container(

                          // group167cge (455:270)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 10 * fem),
                          width: double.infinity,
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(4* fem),
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
                                            primary: AppColors.transparent,
                                            onSurface: AppColors.transparent,
                                            shadowColor: AppColors.transparent,
                                            backgroundColor:
                                                AppColors.primaryPurple),
                                        onPressed: () {
                                          if (_formKeyPan.currentState!
                                                  .validate() &&
                                              _formKeyOwnerName.currentState!
                                                  .validate() &&
                                              _formKeyEmail.currentState!
                                                  .validate() &&
                                              _formKeyrefMob.currentState!
                                                  .validate() &&
                                              _formKeyDob.currentState!
                                                  .validate()) {
                                            controller.handleTemp(context);
                                            // controller.handleSubmition(context);
                                          } else {
                                            _formKeyPan.currentState!
                                                .validate();
                                            _formKeyOwnerName.currentState!
                                                .validate();
                                            _formKeyEmail.currentState!
                                                .validate();
                                            _formKeyrefMob.currentState!
                                                .validate();
                                            _formKeyDob.currentState!
                                                .validate();
                                            print(
                                                "error : ${controller.relationValue}");
                                            if (controller.genderValue
                                                    .toString()
                                                    .length <
                                                2) {
                                              controller.setGenderError(true);
                                            }
                                            if (controller.isMarriedValue
                                                    .toString()
                                                    .length <
                                                2) {
                                              controller
                                                  .setIsMarriedError(true);
                                            }
                                            if (controller.relationValue ==
                                                    null ||
                                                controller.relationValue
                                                    .toString()
                                                    .isEmpty) {
                                              controller.setRelationError(true);
                                            }
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
                                                    TextConstant.confirm,
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
