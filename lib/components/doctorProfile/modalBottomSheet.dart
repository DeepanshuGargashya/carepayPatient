import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:CarePay/res/textConstant.dart';

class ModalBottomSheetWidget extends StatefulWidget {
  GlobalKey<FormState> formKey;
  final controller;
  final editHeader;
  final hintText;

  ModalBottomSheetWidget(
      {super.key,
      required this.formKey,
      required this.controller,
      required this.editHeader,
      required this.hintText});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ModalBottomSheetState();
  }
}

class ModalBottomSheetState extends State<ModalBottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  @override
  void initState() {
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
    final controller = Provider.of<DoctorProfileController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    // TODO: implement build
    return ElevatedButton(
      onPressed: () {
        if ((widget.editHeader.toString() == TextConstant.city &&
                controller.profileTab == TextConstant.bank.toString()) ||
            widget.editHeader == TextConstant.bankName) {
          Utils.toastMessage("Change IFSC code");
        } else if (widget.editHeader.toString() == TextConstant.city &&
            controller.profileTab == TextConstant.address.toString()) {
          Utils.toastMessage("Change PinCode");
        } else if (widget.editHeader.toString() == TextConstant.phoneNumber) {
          Utils.toastMessage("Cannot change phone number");
        } else {
          showModalBottomSheet(
              context: context,
              isDismissible: false,
              enableDrag: false,
              isScrollControlled: true,
              // barrierColor: none,
              // backgroundColor: Colors.green[200],
              backgroundColor: Colors.white,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  final controller = Provider.of<DoctorProfileController>(
                      context,
                      listen: false);
                  return SizedBox(
                    height: controller.editModalHeight * fem,
                    child: Focus(
                      child: Container(
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 25 * fem, 0 * fem, 5 * fem),
                        padding: EdgeInsets.fromLTRB(
                            15 * fem, 0 * fem, 15 * fem, 0 * fem),
                        width: double.infinity,
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
                                child: Text(
                                  '${TextConstant.edit} ${widget.editHeader.toString()}',
                                  style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    // 'Work Sans',
                                    // fontFamily: "DM Sans",
                                    letterSpacing: 0.5,
                                    fontSize: 14 * ffem,
                                    fontWeight: FontWeight.w700,
                                    height: 1.1725 * ffem / fem,
                                    color: AppColors.black.withOpacity(0.8),
                                  ),
                                ),
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
                                key: widget.formKey,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 1.5 * fem),
                                  child: TextFormField(
                                    controller: widget.controller,
                                    // maxLength: 10,
                                    keyboardType: TextInputType.name,
                                    // autofocus: true,
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    onChanged: (value) async {
                                      if (widget.editHeader == "Email ID" &&
                                          RegExp(r'\S+@\S+\.\S+')
                                              .hasMatch(value)) {
                                        widget.formKey.currentState!.validate();
                                      } else if (widget.editHeader == "Pan" &&
                                          value.length > 8) {
                                        widget.formKey.currentState!.validate();
                                      }
                                      // else if (widget.editHeader &&
                                      //     value.length == 11) {
                                      //   widget.formKey.currentState!
                                      //       .validate();
                                      // }
                                      else if (widget.editHeader ==
                                          TextConstant.pincode) {
                                        if (value.length == 6) {
                                          var res = await controller
                                              .fetchPinCodeDetail();
                                          if (res) {
                                            widget.formKey.currentState!
                                                .validate();
                                          }
                                        }
                                      } else if (widget.editHeader ==
                                          TextConstant.ifsc) {
                                        if (value.length == 11) {
                                          var res = await controller
                                              .fetchIFSCCodeDetail();
                                          if (res) {
                                            widget.formKey.currentState!
                                                .validate();
                                          }
                                        }
                                      }
                                    },
                                    decoration: InputDecoration(
                                      counterText: "",
                                      contentPadding: const EdgeInsets.all(15),
                                      fillColor: AppColors.F8F8FF,
                                      filled: true,

                                      hintText: widget.hintText.toString(),

                                      hintStyle: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * ffem / fem,
                                          color: Colors.black54,
                                          letterSpacing: 0.5),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          borderSide: BorderSide.none),
                                      // hintText: '**********',
                                    ),
                                    // autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return '${widget.editHeader.toString()} is Required';
                                      } else if (widget.editHeader ==
                                              "Email ID" &&
                                          !RegExp(r'\S+@\S+\.\S+')
                                              .hasMatch(value)) {
                                        return "Please Enter a Valid Email";
                                      } else if (widget.editHeader == "Pan" &&
                                          (value.length < 10 ||
                                              value.length > 10)) {
                                        return TextConstant.invalidPan;
                                      } else if (widget.editHeader ==
                                          TextConstant.pincode) {
                                        if (value == null || value.isEmpty) {
                                          // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                          return TextConstant.pincode;
                                        } else if (value.length < 6) {
                                          return TextConstant.invalidPincode;
                                        } else if (controller
                                            .pinCodeErrorCode) {
                                          return TextConstant.invalidPincode;
                                        } else {
                                          return null;
                                        }
                                      } else if (widget.editHeader ==
                                          TextConstant.ifsc) {
                                        print("check inside validate error");
                                        if (value.trim().isEmpty) {
                                          return TextConstant.enterIfsc;
                                        } else if (controller.ifscErrorCode) {
                                          print("inside validate error");
                                          return TextConstant.invalidIfsc;
                                        } else {
                                          return null;
                                        }
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 1,
                              height: 10 * fem,
                            ),
                            FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: 2 * space,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (widget.editHeader ==
                                                TextConstant.pincode &&
                                            !controller.loading) {
                                          controller
                                              .setpreviousToEdit("pincode");
                                        } else if (widget.editHeader ==
                                                TextConstant.ifsc &&
                                            !controller.loading) {
                                          controller.setpreviousToEdit("ifsc");
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                            color: AppColors.white),
                                        child: Text(
                                          TextConstant.cancel,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontSize: 14 * fem,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (widget.formKey.currentState!
                                            .validate()) {
                                          print(
                                              "going to hit handle submition");
                                          controller.handleSubmition(context,
                                              widget.editHeader.toString());
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(0 * fem,
                                            15 * fem, 0 * fem, 15 * fem),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.2,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                            color: AppColors.ECEBFF),
                                        child: Text(
                                          TextConstant.submit,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.primaryPurple,
                                              fontSize: 14 * fem,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      onFocusChange: (value) {
                        print(value);
                        if (value) {
                          controller.setEditModalHeight(
                              (MediaQuery.of(context).size.height / 1.6)
                                  .toInt());
                        } else {
                          if (widget.editHeader == TextConstant.pincode &&
                              !controller.loading) {
                            controller.setpreviousToEdit("pincode");
                          } else if (widget.editHeader == TextConstant.ifsc &&
                              !controller.loading) {
                            controller.setpreviousToEdit("ifsc");
                          }
                          controller.setEditModalHeight(200.toInt());
                        }
                      },
                    ),
                  );
                });
              });
        }
      },
      child: Text(TextConstant.edit,
          style: TextStyle(
              fontFamily: 'DM Sans',
              color: AppColors.primaryPurple,
              fontSize: 12 * fem,
              fontWeight: FontWeight.w700)),
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(0),
          backgroundColor: AppColors.ECEBFF,
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6 * fem))),
    );
  }
}
