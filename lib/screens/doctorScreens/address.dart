import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/doctorFlow/addressDoctorDetailController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'professional.dart';

class address extends StatefulWidget {
  const address({Key? key}) : super(key: key);

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<AddressDoctorDetailsController>(context, listen: false);
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

  final formKeyBuilding = GlobalKey<FormState>();
  final formKeyLocality = GlobalKey<FormState>();
  final formKeyPincode = GlobalKey<FormState>();
  final formKeyCity = GlobalKey<FormState>();
  final formKeyState = GlobalKey<FormState>();
  // var _value = '-1';
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<AddressDoctorDetailsController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeftWithFade,
                child: practice()),
          );
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                centerTitle: false,
                automaticallyImplyLeading: false,
                elevation: 0,
                leadingWidth: 0 * fem,
                backgroundColor: AppColors.white,
                title: Column(
                  children: [
                    SizedBox(height: 14 * fem),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 125 * fem,
                            height: 50 * fem,
                            // padding: EdgeInsets.only(top: 25),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/carePayLogo.png')),
                          ),
                          InkWell(
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
                              width: 32 * fem,
                              height: 32 * fem,
                              // padding: EdgeInsets.only(top: 25),
                              child: Image(
                                  image: AssetImage(
                                      'assets/images/headphone.png')),
                            ),
                          ),
                        ]),
                  ],
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(28.0 * fem),
                  child: Container(
                    padding: EdgeInsets.only(top: 18),
                    child: BreadCrumb(
                      items: <BreadCrumbItem>[
                        BreadCrumbItem(
                            content: Text(
                          TextConstant.personal,
                          style: TextStyle(
                            color: AppColors.primaryPurple,
                            fontFamily: 'DM Sans',
                            // fontWeight: FontWeight.w600,
                            fontSize: 14 * fem,
                          ),
                        )),
                        BreadCrumbItem(
                            content: Text(
                              TextConstant.practice,
                              style: TextStyle(
                                color: AppColors.primaryPurple,
                                fontFamily: 'DM Sans',
                                // fontWeight: FontWeight.w600,
                                fontSize: 14 * fem,
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: practice()),
                              );
                            }),
                        BreadCrumbItem(
                            content: Text(TextConstant.address,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22 * fem,
                                    color: AppColors.primaryPurple))),
                        BreadCrumbItem(
                            content: Text(TextConstant.bankDetails,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 14 * fem,
                                    color: AppColors.grey))),
                        BreadCrumbItem(
                            content: Text(TextConstant.documents,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    // fontWeight: FontWeight.w600,
                                    fontSize: 14 * fem,
                                    color: AppColors.grey))),
                      ],
                      divider:
                          Icon(Icons.chevron_right, color: AppColors.white),
                      overflow: ScrollableOverflow(
                        // keepLastDivider: true,
                        reverse: true,
                        direction: Axis.horizontal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.19,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(TextConstant.building,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyBuilding,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    controller: controller.building,

                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        formKeyBuilding.currentState!
                                            .validate();
                                      }
                                    },
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterBuilding,
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),

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

                                        return TextConstant.enterBuildingg;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.doctorLocality,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyLocality,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    controller: controller.locality,
                                    // obscureText: true,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        formKeyLocality.currentState!
                                            .validate();
                                      }
                                    },
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterLocality,
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),

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

                                        return TextConstant.enterLocalityy;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
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
                                  key: formKeyPincode,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    keyboardType: TextInputType.number,
                                    controller: controller.pinCode,
                                    onChanged: (value) async {
                                      if (value.length == 6) {
                                        var res = await controller
                                            .fetchPinCodeDetail();
                                        if (res) {
                                          formKeyPincode.currentState!
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
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),

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

                                        return TextConstant.pincodeee;
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
                              Container(
                                padding: EdgeInsets.only(top: 6 * fem),
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
                                  key: formKeyCity,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    enabled: false,
                                    enableInteractiveSelection: false,
                                    focusNode: FocusNode(),
                                    controller: controller.city,
                                    onChanged: (value) {
                                      // if (value.length > 8) {
                                      //   formKeyCity.currentState!.validate();
                                      // }
                                    },

                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterCity,
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),

                                        // border : InputBorder.none,

                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4 * fem),
                                            borderSide: BorderSide.none)
                                        // ),

                                        ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]
                                    //
                                    //     return TextConstant.invalidPincode;
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22 * fem),
                                child: Text(TextConstant.state,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyState,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    enabled: false,
                                    enableInteractiveSelection: false,
                                    focusNode: FocusNode(),
                                    controller: controller.stateController,
                                    onChanged: (value) {
                                      // if (value.length > 8) {
                                      //   formKeyState.currentState!.validate();
                                      // }
                                    },

                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterStates,
                                        hintStyle: TextStyle(
                                          color:
                                              AppColors.black.withOpacity(0.4),
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),

                                        // border : InputBorder.none,

                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4 * fem),
                                            borderSide: BorderSide.none)
                                        // ),

                                        ),
                                    // validator: (value) {
                                    //   if (value == null || value.isEmpty) {
                                    //     // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]
                                    //
                                    //     return TextConstant.invalidPincode;
                                    //   } else {
                                    //     return null;
                                    //   }
                                    // },
                                  ),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 22 * fem, left: 0, right: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 15 * fem, 0, 15 * fem),
                                              child: Text(
                                                TextConstant.next,
                                                style: TextStyle(
                                                    color: AppColors.white,
                                                    fontFamily: 'DM Sans',
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14 * fem),
                                              ),
                                            ),
                                            onPressed: () {
                                              if (formKeyBuilding.currentState!
                                                          .validate() &&
                                                      formKeyLocality
                                                          .currentState!
                                                          .validate() &&
                                                      formKeyPincode
                                                          .currentState!
                                                          .validate()
                                                  // &&
                                                  //     formKeyCity.currentState!
                                                  //         .validate() &&
                                                  //     formKeyState.currentState!
                                                  //         .validate()
                                                  // controller.isEmpty()
                                                  ) {
                                                controller
                                                    .handleSubmition(context);
                                              } else {
                                                formKeyBuilding.currentState!
                                                    .validate();
                                                formKeyLocality.currentState!
                                                    .validate();
                                                formKeyPincode.currentState!
                                                    .validate();
                                                // formKeyCity.currentState!
                                                //     .validate();
                                                // formKeyState.currentState!
                                                //     .validate();
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary:
                                                    AppColors.primaryPurple,

                                                // fixedSize: Size(380, 50),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4 * fem)))),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Container(
                              //   // padding: EdgeInsets.only( top:10),
                              //   child: Center(
                              //     child: ElevatedButton(
                              //         child: Text(
                              //           TextConstant.next,
                              //           style: TextStyle(
                              //             fontFamily: 'DM Sans',
                              //             fontSize: 14 * fem,
                              //             fontWeight: FontWeight.w700,
                              //           ),
                              //         ),
                              //         onPressed: () {
                              //           if (formKeyBuilding.currentState!.validate() &&
                              //                   formKeyLocality.currentState!
                              //                       .validate() &&
                              //                   formKeyPincode.currentState!
                              //                       .validate() &&
                              //                   formKeyCity.currentState!
                              //                       .validate() &&
                              //                   formKeyState.currentState!
                              //                       .validate()
                              //               // controller.isEmpty()
                              //               ) {
                              //             controller.handleSubmition(context);
                              //           } else {
                              //             formKeyBuilding.currentState!
                              //                 .validate();
                              //             formKeyLocality.currentState!
                              //                 .validate();
                              //             formKeyPincode.currentState!.validate();
                              //             formKeyCity.currentState!.validate();
                              //             formKeyState.currentState!.validate();
                              //           }
                              //         },
                              //         style: ElevatedButton.styleFrom(
                              //             primary: AppColors.primaryPurple,
                              //             fixedSize: Size(370, 50),
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10)))),
                              //   ),
                              // ),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
