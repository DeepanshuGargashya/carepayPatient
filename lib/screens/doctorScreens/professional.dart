import 'package:CarePay/screens/doctorScreens/personal_details.dart';
import 'package:CarePay/view_model/doctorFlow/professionalDetailController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:url_launcher/url_launcher.dart';

class practice extends StatefulWidget {
  const practice({Key? key}) : super(key: key);

  @override
  State<practice> createState() => _practiceState();
}

class _practiceState extends State<practice>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<ProfessionalDetailController>(context, listen: false);
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

  final formKeyLicense = GlobalKey<FormState>();
  final formKeyClinic = GlobalKey<FormState>();
  final formKeyEntity = GlobalKey<FormState>();
  final formKeyCin = GlobalKey<FormState>();
  final formKeyGstin = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProfessionalDetailController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: details()),
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
                        // SizedBox(height: 17 * fem),
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
                  margin: EdgeInsets.fromLTRB(10, 18, 0, 0),
                  child: BreadCrumb(
                    items: <BreadCrumbItem>[
                      BreadCrumbItem(
                          content: Text(TextConstant.personal,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  // fontWeight: FontWeight.w600,
                                  fontSize: 14 * fem,
                                  color: AppColors.primaryPurple)),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeftWithFade,
                                  child: details()),
                            );
                          }),
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.practice,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 22 * fem,
                            color: AppColors.primaryPurple),
                      )),
                      BreadCrumbItem(
                          content: Text(
                        TextConstant.address,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            // fontWeight: FontWeight.w600,
                            fontSize: 14 * fem,
                            color: AppColors.grey),
                      )),
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
                    divider: Icon(Icons.chevron_right, color: AppColors.white),
                    overflow: ScrollableOverflow(
                      keepLastDivider: true,
                      reverse: false,
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
                        child: Container(
                          // height: MediaQuery.of(context).size.height/1.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 16),
                                child: Text(TextConstant.license,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14 * fem,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyLicense,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    onChanged: (value) {
                                      if (value.length > 6) {
                                        formKeyLicense.currentState!.validate();
                                      }
                                    },
                                    controller: controller.licenceNumber,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterLicense,
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

                                        return TextConstant.enterLicensee;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                // group167cge (455:270)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10, 0 * fem, 0 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // FadeSlideTransition(
                                    // animation: _formElementAnimation,
                                    // additionalOffset: fem,
                                    // additionalOffset: 0.0,
                                    Container(
                                      // emailidwU2 (455:267)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.speciality,
                                          style: TextStyle(
                                            // 'Work Sans',
                                            fontFamily: 'DM Sans',
                                            // letterSpacing: 0.5,
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.1725 * fem / fem,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ])),
                                    ),
                                    // ),
                                    // FadeSlideTransition(
                                    //   animation: _formElementAnimation,
                                    //   additionalOffset: fem,
                                    //   additionalOffset: 0.0,
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.ECEBFF,
                                            borderRadius:
                                                BorderRadius.circular(4 * fem)),
                                        child: ButtonTheme(
                                            buttonColor: AppColors.ECEBFF,
                                            alignedDropdown: true,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 4 * fem, 0, 4 * fem),
                                              child: DropdownButton(
                                                alignment: AlignmentDirectional
                                                    .centerStart,
                                                underline: SizedBox(),
                                                dropdownColor: AppColors.ECEBFF,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                isExpanded: true,
                                                // elevation: 2,
                                                hint: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    TextConstant
                                                        .selectFromBelow,
                                                    style: TextStyle(
                                                      color: AppColors.black
                                                          .withOpacity(0.4),
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 14 * fem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),

                                                value: controller
                                                    .specialityDropdownValue,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                items: controller
                                                    .specialityTypeDropDown
                                                    .map((data) {
                                                  return DropdownMenuItem(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      value: data,
                                                      child: Row(
                                                        children: [
                                                          // SizedBox(
                                                          //   width: 10,
                                                          // ),
                                                          Expanded(
                                                            child: Text(
                                                              data,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
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
                                                      .setspecialityTypeValue(
                                                          value.toString());
                                                },
                                              ),
                                            )),
                                      ),
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.clinicName,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14 * fem,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyClinic,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    controller: controller.clinicName,
                                    onChanged: (value) {
                                      if (value.length > 2) {
                                        formKeyClinic.currentState!.validate();
                                      }
                                    },
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterClinic,
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

                                        return TextConstant.enterClinicc;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.businessEntity,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyEntity,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        formKeyEntity.currentState!.validate();
                                      }
                                    },
                                    controller: controller.businessEntityName,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText:
                                            TextConstant.enterBusinessEntity,
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

                                        return TextConstant
                                            .enterBusinessEntityy;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                // group167cge (455:270)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // FadeSlideTransition(
                                    // animation: _formElementAnimation,
                                    // additionalOffset: fem,
                                    // additionalOffset: 0.0,
                                    Container(
                                      // emailidwU2 (455:267)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 10 * fem, 0 * fem, 5 * fem),
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.typeEntity,
                                          style: TextStyle(
                                            // 'Work Sans',
                                            fontFamily: 'DM Sans',
                                            // letterSpacing: 0.5,
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.1725 * fem / fem,
                                            color: AppColors.black,
                                          ),
                                        ),
                                      ])),
                                    ),
                                    // ),
                                    // FadeSlideTransition(
                                    //   animation: _formElementAnimation,
                                    //   additionalOffset: fem,
                                    //   additionalOffset: 0.0,
                                    Padding(
                                      padding: const EdgeInsets.only(top: 6),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: AppColors.ECEBFF,
                                            borderRadius:
                                                BorderRadius.circular(4 * fem)),
                                        child: ButtonTheme(
                                            buttonColor: AppColors.ECEBFF,
                                            alignedDropdown: true,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 4 * fem, 0, 4 * fem),
                                              child: DropdownButton(
                                                underline: SizedBox(),
                                                dropdownColor: AppColors.ECEBFF,
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_down),
                                                isExpanded: true,
                                                elevation: 2,
                                                hint: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    TextConstant
                                                        .selectFromBelow,
                                                    style: TextStyle(
                                                      color: AppColors.black
                                                          .withOpacity(0.4),
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 14 * fem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                value: controller
                                                    .entityDropdownValue,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleMedium,
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                items: controller
                                                    .entityTypeDropDown
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
                                                  controller.setentityTypeValue(
                                                      value.toString());
                                                  // setState(() {
                                                  //   addressDropdownValue = value.toString() ;
                                                  //   isEmpty();
                                                  // });
                                                  // print(staffDropdownvalue);
                                                },
                                              ),
                                            )),
                                      ),
                                    ),
                                    // ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.cin,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: TextFormField(
                                  style: const TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      height: 1.5),
                                  controller: controller.cinLlpin,
                                  // obscureText: true,
                                  decoration: InputDecoration(
                                      fillColor: AppColors.ECEBFF,
                                      filled: true,
                                      hintText: TextConstant.enterCin,
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
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 22),
                                child: Text(TextConstant.gstin,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.black)),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Form(
                                  key: formKeyGstin,
                                  child: TextFormField(
                                    style: const TextStyle(
                                        fontFamily: 'DM Sans',
                                        fontSize: 16,
                                        height: 1.5),
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        formKeyGstin.currentState!.validate();
                                      }
                                    },
                                    controller: controller.gstIn,
                                    // obscureText: true,
                                    decoration: InputDecoration(
                                        fillColor: AppColors.ECEBFF,
                                        filled: true,
                                        hintText: TextConstant.enterGstin,
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
                                      // if (value == null || value.isEmpty) {
                                      //   // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                      //   return TextConstant.enterGstin;
                                      // } else {
                                      return null;
                                      // }
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
                                              if (formKeyLicense.currentState!
                                                      .validate() &&
                                                  formKeyClinic.currentState!
                                                      .validate() &&
                                                  formKeyEntity.currentState!
                                                      .validate() &&
                                                  // formKeyCin.currentState!.validate() &&
                                                  formKeyGstin.currentState!
                                                      .validate() &&
                                                  controller.isEmpty()) {
                                                controller
                                                    .handleSubmition(context);
                                              } else {
                                                formKeyLicense.currentState!
                                                    .validate();
                                                formKeyClinic.currentState!
                                                    .validate();
                                                formKeyEntity.currentState!
                                                    .validate();
                                                // formKeyCin.currentState!.validate() ;
                                                formKeyGstin.currentState!
                                                    .validate();
                                                // controller.isEmpty() ;
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: controller.isEmpty()
                                                    ? AppColors.primaryPurple
                                                    : AppColors.primaryPurple
                                                        .withOpacity(0.4),
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
                              //             fontFamily: 'DM Sans',
                              //             fontSize: 14 * fem,
                              //             fontWeight: FontWeight.w700,
                              //           ),
                              //         ),
                              //         onPressed: () {
                              //           if (formKeyLicense.currentState!
                              //                   .validate() &&
                              //               formKeyClinic.currentState!
                              //                   .validate() &&
                              //               formKeyEntity.currentState!
                              //                   .validate() &&
                              //               // formKeyCin.currentState!.validate() &&
                              //               formKeyGstin.currentState!
                              //                   .validate() &&
                              //               controller.isEmpty()) {
                              //             controller.handleSubmition(context);
                              //           } else {
                              //             formKeyLicense.currentState!
                              //                 .validate();
                              //             formKeyClinic.currentState!
                              //                 .validate();
                              //             formKeyEntity.currentState!
                              //                 .validate();
                              //             // formKeyCin.currentState!.validate() ;
                              //             formKeyGstin.currentState!.validate();
                              //             // controller.isEmpty() ;
                              //           }
                              //         },
                              //         style: ElevatedButton.styleFrom(
                              //             primary: controller.isEmpty()
                              //                 ? AppColors.primaryPurple
                              //                 : AppColors.primaryPurple
                              //                     .withOpacity(0.4),
                              //             fixedSize: Size(370, 50),
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10)))),
                              //   ),
                              // ),
                              SizedBox(
                                height: 25,
                              )
                            ],
                          ),
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
