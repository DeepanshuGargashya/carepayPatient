import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/screens/doctorScreens/address.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/doctorBankDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:url_launcher/url_launcher.dart';

class bank_details extends StatefulWidget {
  const bank_details({Key? key}) : super(key: key);

  @override
  State<bank_details> createState() => _bank_detailsState();
}

class _bank_detailsState extends State<bank_details>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<DoctorBankDetailsController>(context, listen: false);
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

  final formKeyAccount = GlobalKey<FormState>();
  final formKeyConfirmAccount = GlobalKey<FormState>();
  final formKeyHolderName = GlobalKey<FormState>();
  final formKeyIfsc = GlobalKey<FormState>();
  final formKeyBankName = GlobalKey<FormState>();
  final formKeyCity = GlobalKey<FormState>();

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DoctorBankDetailsController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: address()),
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
                              image:
                                  AssetImage('assets/images/carePayLogo.png')),
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
                                image:
                                    AssetImage('assets/images/headphone.png')),
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
                          fontSize: 14 * fem,
                          // fontWeight: FontWeight.w600,
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
                      )),
                      BreadCrumbItem(
                          content: Text(
                            TextConstant.address,
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
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: address()),
                            );
                          }),
                      BreadCrumbItem(
                          content: Text(TextConstant.bankDetails,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 22 * fem,
                                  color: AppColors.primaryPurple))),
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.documents,
                        style: TextStyle(
                          color: AppColors.grey,
                          fontFamily: 'DM Sans',
                          // fontWeight: FontWeight.w600,
                          fontSize: 14 * fem,
                        ),
                      )),
                    ],
                    divider: Icon(Icons.chevron_right, color: Colors.white),
                    overflow: ScrollableOverflow(
                      // forward: true,
                      physics: ScrollPhysics(),
                      keepLastDivider: true,
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
                              child: Text(TextConstant.accountNumber,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyAccount,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  keyboardType: TextInputType.number,
                                  controller: controller.accountNumber,
                                  obscureText: controller.passwordVisible,
                                  enableSuggestions: false,
                                  onChanged: (value) {
                                    if (value.length > 0) {
                                      formKeyAccount.currentState!.validate();
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enteracountNumber,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(controller.passwordVisible
                                      //       ? Icons.visibility_off
                                      //       : Icons.visibility),
                                      //   onPressed: () {
                                      //     controller.setPasswordVisible("pass");
                                      //   },
                                      // ),
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

                                      return TextConstant.enteracountNumberr;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.confirmAcountNumber,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyConfirmAccount,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  obscureText:
                                      controller.confirmPasswordVisible,
                                  enableSuggestions: false,
                                  keyboardType: TextInputType.number,
                                  enableInteractiveSelection: false,
                                  controller: controller.confirmAccountNumber,
                                  onChanged: (value) {
                                    if (value.length ==
                                        controller.accountNumber.text
                                            .toString()
                                            .length) {
                                      if (controller.accountNumber.text
                                          .toString()
                                          .startsWith(value)) {
                                        formKeyConfirmAccount.currentState!
                                            .validate();
                                      } else {
                                        return null;
                                      }
                                    } else {
                                      // formKeyConfirmAccount.currentState!
                                      //     .validate();
                                      return null;
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText:
                                          TextConstant.reenteracountNumber,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                      ),

                                      // border : InputBorder.none,
                                      // suffixIcon: IconButton(
                                      //   icon: Icon(
                                      //       controller.confirmPasswordVisible
                                      //           ? Icons.visibility_off
                                      //           : Icons.visibility),
                                      //   onPressed: () {
                                      //     controller
                                      //         .setPasswordVisible("cpass");
                                      //   },
                                      // ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4 * fem),
                                          borderSide: BorderSide.none)
                                      // ),

                                      ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return TextConstant.reenteracountNumberrr;
                                      // if(){}
                                    }
                                    if (value !=
                                        controller.accountNumber.text
                                            .toString()) {
                                      return TextConstant.acountNumberNotMatch;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.acountHolderName,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyHolderName,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  controller: controller.accountHolderName,
                                  onChanged: (value) {
                                    if (value.length > 2) {
                                      formKeyHolderName.currentState!
                                          .validate();
                                    }
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText:
                                          TextConstant.enteracountHolderName,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
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

                                      return TextConstant
                                          .enteracountHolderNamee;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.ifsc,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyIfsc,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  controller: controller.ifscCode,
                                  onChanged: (value) async {
                                    if (value.length == 11) {
                                      var res = await controller
                                          .fetchIFSCCodeDetail();
                                      if (res) {
                                        formKeyIfsc.currentState!.validate();
                                      }
                                    }
                                    if (value.length > 9) {
                                      // formKeyIfsc.currentState!.validate();
                                    }
                                    controller.ifscCode.value =
                                        TextEditingValue(
                                            text: value.toUpperCase(),
                                            selection:
                                                controller.ifscCode.selection);
                                  },
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterIfsc,
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
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
                                    if (value!.trim().isEmpty) {
                                      return TextConstant.enterIfscc;
                                    } else if (controller.ifscErrorCode) {
                                      return TextConstant.invalidIfsc;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
                              child: Text(TextConstant.bankName,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.black)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Form(
                                key: formKeyBankName,
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  enabled: false,
                                  enableInteractiveSelection: false,
                                  focusNode: FocusNode(),
                                  controller: controller.bankName,
                                  onChanged: (value) {
                                    if (value.length > 2) {
                                      formKeyBankName.currentState!.validate();
                                    }
                                  },

                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: "Bank name",
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
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

                                      return TextConstant.enterBankName;
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 22),
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
                                    if (value.length > 2) {
                                      formKeyCity.currentState!.validate();
                                    }
                                  },

                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: "Enter city here",
                                      hintStyle: TextStyle(
                                        color: AppColors.black.withOpacity(0.4),
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

                                      return TextConstant.enterCity;
                                    } else {
                                      return null;
                                    }
                                  },
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
                                            if (!controller.ifscErrorCode) {
                                              if (formKeyAccount.currentState!
                                                          .validate() &&
                                                      formKeyConfirmAccount
                                                          .currentState!
                                                          .validate() &&
                                                      formKeyHolderName
                                                          .currentState!
                                                          .validate() &&
                                                      formKeyIfsc.currentState!
                                                          .validate()
                                                  // &&
                                                  //     formKeyBankName
                                                  //         .currentState!
                                                  //         .validate() &&
                                                  //     formKeyCity.currentState!
                                                  //         .validate()
                                                  // && formKeyMob.currentState!.validate()
                                                  ) {
                                                controller
                                                    .handleSubmition(context);
                                              } else {
                                                formKeyAccount.currentState!
                                                    .validate();
                                                formKeyConfirmAccount
                                                    .currentState!
                                                    .validate();
                                                formKeyHolderName.currentState!
                                                    .validate();
                                                formKeyIfsc.currentState!
                                                    .validate();
                                                // formKeyBankName.currentState!
                                                //     .validate();
                                                // formKeyCity.currentState!
                                                //     .validate();
                                              }
                                            } else {
                                              Utils.toastMessage(
                                                  "invalid IFSC code");
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: AppColors.primaryPurple,
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
                            //   padding: EdgeInsets.only(top: 20),
                            //   child: Center(
                            //     child: ElevatedButton(
                            //         child: Text(
                            //           TextConstant.next,
                            //           style: TextStyle(
                            //               fontFamily: 'DM Sans',
                            //               fontWeight: FontWeight.w700,
                            //               fontSize: 14 * fem),
                            //         ),
                            //         onPressed: () {
                            //           if (!controller.ifscErrorCode) {
                            //             if (formKeyAccount.currentState!
                            //                         .validate() &&
                            //                     formKeyConfirmAccount
                            //                         .currentState!
                            //                         .validate() &&
                            //                     formKeyHolderName.currentState!
                            //                         .validate() &&
                            //                     formKeyIfsc.currentState!
                            //                         .validate() &&
                            //                     formKeyBankName.currentState!
                            //                         .validate() &&
                            //                     formKeyCity.currentState!
                            //                         .validate()
                            //                 // && formKeyMob.currentState!.validate()
                            //                 ) {
                            //               controller.handleSubmition(context);
                            //             } else {
                            //               formKeyAccount.currentState!
                            //                   .validate();
                            //               formKeyConfirmAccount.currentState!
                            //                   .validate();
                            //               formKeyHolderName.currentState!
                            //                   .validate();
                            //               formKeyIfsc.currentState!.validate();
                            //               formKeyBankName.currentState!
                            //                   .validate();
                            //               formKeyCity.currentState!.validate();
                            //             }
                            //           } else {
                            //             Utils.toastMessage("invalid IFSC code");
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
                            )
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
    );
  }
}
