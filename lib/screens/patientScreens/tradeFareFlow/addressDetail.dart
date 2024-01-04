import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/personalDetail.dart';
import 'package:CarePay/view_model/patientFlow/addressDetailController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import '../../../res/textConstant.dart';

class AddressDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressDetailState();
  }
}

class AddressDetailState extends State<AddressDetailScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyAddress = GlobalKey<FormState>();

  final _formKeyPincode = GlobalKey<FormState>();
  final _formKeyCity = GlobalKey<FormState>();
  // final _formKeyState = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<AddressDetailController>(context, listen: false);
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
    final controller = Provider.of<AddressDetailController>(context);
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
                child: PersonalDetailScreen()),
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
                  // Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeftWithFade,
                        child: PersonalDetailScreen()),
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
                        new LinearPercentIndicator(
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
                              TextConstant.addressDetailHeader,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16 * fem),
                            )),
                      ),
                      Visibility(
                        visible: controller.cibilVisibility,
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
                                additionalOffset: 0.0,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                  child:
                                      Text.rich(TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                      text: TextConstant.selectAddress,
                                      style: TextStyle(
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
                                            .allAddressesDropdownValue,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                        borderRadius:
                                            BorderRadius.circular(4 * fem),
                                        items: controller.allAddressesDropDown
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
                                                        fontSize: 15,
                                                        fontFamily: 'DM Sans',
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ));
                                        }).toList(),
                                        onChanged: (value) {
                                          controller.setAllAddressesValue(
                                              value.toString());
                                        },
                                      )),
                                ),
                              ),
                            ],
                          ),
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
                                    text: TextConstant.addressType,
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
                                        in controller.addressTypeOptions) ...[
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
                                          groupValue: controller
                                              .addressTypeValue
                                              .toString(),
                                          onChanged: (value) {
                                            controller.setAddressType(
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

                      if (controller.addressTypeError) ...[
                        Text('     Please select address type',
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.redError,
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.w500)),
                      ],

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
                              additionalOffset: 0.0,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.residenceType,
                                    style: TextStyle(
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
                                      value: controller.residenceDropdownValue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      borderRadius:
                                          BorderRadius.circular(4 * fem),
                                      items: controller.residenceDropdown
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
                                                      fontSize: 15,
                                                      fontFamily: 'DM Sans',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        controller.setResidenceTypeValue(
                                            value.toString());
                                      },
                                    )),
                              ),
                            ),
                            if (controller.residenceTypeError) ...[
                              Text('     Please select above field',
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.redError,
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w500)),
                            ],
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
                              additionalOffset: 0.0,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.addressTitle,
                                    style: TextStyle(
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
                                key: _formKeyAddress,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: controller.addressController,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        _formKeyAddress.currentState!
                                            .validate();
                                      }
                                    },
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    minLines: 3,
                                    maxLines: 3,
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding: const EdgeInsets.all(15),
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.firstLineHere,
                                      hintStyle: TextStyle(
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TextConstant
                                            .firstLineHereRequired;
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

                      // Container(
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4 * fem),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         additionalOffset: 0.0,
                      //         child: Container(
                      //           margin: EdgeInsets.fromLTRB(
                      //               0 * fem, 10 * fem, 0 * fem, 5 * fem),
                      //           child:
                      //               Text.rich(TextSpan(children: <InlineSpan>[
                      //             TextSpan(
                      //               text: TextConstant.locality,
                      //               style: TextStyle(
                      //                 fontFamily: "DM Sans",
                      //                 letterSpacing: 0.5,
                      //                 fontSize: 14 * ffem,
                      //                 fontWeight: FontWeight.w400,
                      //                 height: 1.1725 * ffem / fem,
                      //                 color: AppColors.black,
                      //               ),
                      //             ),
                      //           ])),
                      //         ),
                      //       ),
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         additionalOffset: 2 * space,
                      //         child: Form(
                      //           key: _formKeyLocality,
                      //           child: Container(
                      //             margin: EdgeInsets.fromLTRB(
                      //                 0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                      //             child: TextFormField(
                      //               controller: controller.localityController,
                      //               onChanged: (value) {
                      //                 if (value.length > 0) {
                      //                   _formKeyLocality.currentState!
                      //                       .validate();
                      //                 }
                      //               },
                      //               style: const TextStyle(
                      //                   fontFamily: 'DM Sans',
                      //                   fontSize: 16,
                      //                   height: 1.5),
                      //               decoration: InputDecoration(
                      //                 counterText: "",
                      //                 contentPadding: const EdgeInsets.all(15),
                      //                 fillColor: AppColors.ECEBFF,
                      //                 filled: true,
                      //                 hintText: TextConstant.enterLocality,
                      //                 hintStyle: TextStyle(
                      //                     fontFamily: "DM Sans",
                      //                     fontSize: 14 * ffem,
                      //                     fontWeight: FontWeight.w400,
                      //                     height: 1.1725 * ffem / fem,
                      //                     color: AppColors.black54,
                      //                     letterSpacing: 0.5),
                      //                 border: OutlineInputBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4 * fem),
                      //                     borderSide: BorderSide.none),
                      //               ),
                      //               validator: (value) {
                      //                 // if (value!.trim().isEmpty) {
                      //                 //   return TextConstant.localityRequired;
                      //                 // } else {
                      //                 return null;
                      //                 // }
                      //               },
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(4 * fem),
                      //   ),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         additionalOffset: 0.0,
                      //         child: Container(
                      //           margin: EdgeInsets.fromLTRB(
                      //               0 * fem, 10 * fem, 0 * fem, 5 * fem),
                      //           child:
                      //               Text.rich(TextSpan(children: <InlineSpan>[
                      //             TextSpan(
                      //               text: TextConstant.landmark,
                      //               style: TextStyle(
                      //                 fontFamily: "DM Sans",
                      //                 letterSpacing: 0.5,
                      //                 fontSize: 14 * ffem,
                      //                 fontWeight: FontWeight.w400,
                      //                 height: 1.1725 * ffem / fem,
                      //                 color: AppColors.black,
                      //               ),
                      //             ),
                      //           ])),
                      //         ),
                      //       ),
                      //       FadeSlideTransition(
                      //         animation: _formElementAnimation,
                      //         additionalOffset: 2 * space,
                      //         child: Form(
                      //           key: _formKeyLandmark,
                      //           child: Container(
                      //             margin: EdgeInsets.fromLTRB(
                      //                 0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                      //             child: TextFormField(
                      //               controller: controller.landmarkController,
                      //               // onChanged: (value) {
                      //               //   if (value.length > 1) {}
                      //               // },
                      //               style: const TextStyle(
                      //                   fontFamily: 'DM Sans',
                      //                   fontSize: 16,
                      //                   height: 1.5),
                      //               decoration: InputDecoration(
                      //                 counterText: "",
                      //                 contentPadding: const EdgeInsets.all(15),
                      //                 fillColor: AppColors.ECEBFF,
                      //                 filled: true,
                      //                 hintText: TextConstant.enterLandmark,
                      //                 hintStyle: TextStyle(
                      //                     fontFamily: "DM Sans",
                      //                     fontSize: 14 * ffem,
                      //                     fontWeight: FontWeight.w400,
                      //                     height: 1.1725 * ffem / fem,
                      //                     color: AppColors.black54,
                      //                     letterSpacing: 0.5),
                      //                 border: OutlineInputBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(4 * fem),
                      //                     borderSide: BorderSide.none),
                      //               ),
                      //               validator: (value) {
                      //                 // if (value!.trim().isEmpty) {
                      //                 //   return TextConstant.landmarkRequired;
                      //                 // } else {
                      //                 return null;
                      //                 // }
                      //               },
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),

                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 2 * space,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.pincodee,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyPincode,
                                child: TextFormField(
                                  controller: controller.pincodeController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) async {
                                    if (value.length == 6) {
                                      var res = await controller
                                          .fetchPinCodeDetail(context);
                                      if (res) {
                                        _formKeyPincode.currentState!
                                            .validate();
                                      }
                                    }
                                  },
                                  maxLength: 6,
                                  // obscureText: true,

                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.pincode,

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

                                      return TextConstant.pincode;
                                    } else if (value.length < 6) {
                                      return TextConstant.invalidPincode;
                                    } else if (controller.pinCodeErrorCode) {
                                      return TextConstant.invalidPincode;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: 2 * space,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 6),
                              child: Text(TextConstant.city,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: _formKeyCity,
                                child: TextFormField(
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  focusNode: FocusNode(),
                                  controller: controller.cityController,
                                  onChanged: (value) {
                                    // if (value.length > 8) {
                                    //   formKeyCity.currentState!.validate();
                                    // }
                                  },
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w400),
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterCity,

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

                                      return TextConstant.invalidPincode;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
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
                              additionalOffset: 0.0,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                child:
                                    Text.rich(TextSpan(children: <InlineSpan>[
                                  TextSpan(
                                    text: TextConstant.state,
                                    style: TextStyle(
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
                                      value: controller.stateDropdownValue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                      borderRadius:
                                          BorderRadius.circular(4 * fem),
                                      items:
                                          controller.stateDropDown.map((data) {
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
                                                      fontSize: 15,
                                                      fontFamily: 'DM Sans',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ));
                                      }).toList(),
                                      onChanged: (value) {
                                        controller
                                            .setStateDropdown(value.toString());
                                      },
                                    )),
                              ),
                            ),

                            if (controller.stateDropdownError) ...[
                              Text('     Please select state',
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.redError,
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w500)),
                            ],

                            // FadeSlideTransition(
                            //   animation: _formElementAnimation,
                            //   additionalOffset: 2 * space,
                            //   child: Form(
                            //     key: _formKeyState,
                            //     child: Container(
                            //       margin: EdgeInsets.fromLTRB(
                            //           0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                            //       child: TextFormField(
                            //         enabled: false,
                            //         enableInteractiveSelection: false,
                            //         focusNode: FocusNode(),
                            //         controller: controller.stateController,
                            //         style: const TextStyle(
                            //             color: AppColors.black,
                            //             fontWeight: FontWeight.w400,
                            //             fontSize: 16,
                            //             height: 1.5),
                            //         decoration: InputDecoration(
                            //           counterText: "",
                            //           contentPadding: const EdgeInsets.all(15),
                            //           fillColor: AppColors.ECEBFF,
                            //           filled: true,
                            //           hintText: TextConstant.enterState,
                            //           hintStyle: TextStyle(
                            //               fontFamily: "DM Sans",
                            //               fontSize: 14 * ffem,
                            //               fontWeight: FontWeight.w400,
                            //               height: 1.1725 * ffem / fem,
                            //               color: AppColors.black54,
                            //               letterSpacing: 0.5),
                            //           border: OutlineInputBorder(
                            //               borderRadius:
                            //                   BorderRadius.circular(4 * fem),
                            //               borderSide: BorderSide.none),
                            //         ),
                            //         validator: (value) {
                            //           if (value!.trim().isEmpty) {
                            //             return TextConstant.stateRequired;
                            //           } else {
                            //             return null;
                            //           }
                            //         },
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 18 * fem, 0 * fem, 20 * fem),
                          width: double.infinity,
                          child: FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: space,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 0 * fem),
                                          primary: AppColors.primaryPurple,
                                        ),
                                        onPressed: () {
                                          if (_formKeyAddress.currentState!.validate() &&
                                              _formKeyPincode.currentState!
                                                  .validate() &&
                                              _formKeyCity.currentState!
                                                  .validate() &&
                                              controller.isEmptyy()) {
                                            // controller.handleTemp(context);
                                            controller.handleSubmition(context);
                                          } else {
                                            _formKeyAddress.currentState!
                                                .validate();

                                            _formKeyPincode.currentState!
                                                .validate();
                                            _formKeyCity.currentState!
                                                .validate();
                                            controller.isEmptyy();
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
