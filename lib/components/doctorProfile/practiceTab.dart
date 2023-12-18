import 'package:CarePay/components/doctorProfile/eachDetail.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:CarePay/res/textConstant.dart';

class PracticeTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PracticeTabState();
  }
}

class PracticeTabState extends State<PracticeTabScreen>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _formKeyEditName = GlobalKey<FormState>();
  final _formKeyEditEmail = GlobalKey<FormState>();
  final _formKeyEditPan = GlobalKey<FormState>();
  final _formKeyEditMob = GlobalKey<FormState>();

  final _formKeyEditBuilding = GlobalKey<FormState>();
  final _formKeyEditLocality = GlobalKey<FormState>();
  final _formKeyEditPincode = GlobalKey<FormState>();
  final _formKeyEditCity = GlobalKey<FormState>();

  final _formKeyEditLicense = GlobalKey<FormState>();
  final _formKeyEditClinicName = GlobalKey<FormState>();
  final _formKeyEditBuisnessEntity = GlobalKey<FormState>();

  final _formKeyEditAccount = GlobalKey<FormState>();
  final _formKeyEditHolderName = GlobalKey<FormState>();
  final _formKeyEditIFSC = GlobalKey<FormState>();
  final _formKeyEditBankName = GlobalKey<FormState>();
  final _formKeyEditBranchName = GlobalKey<FormState>();

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

  var editModalHeight = 200;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DoctorProfileController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;

    return Container(
        padding: EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
        // group167cge (455:270)
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: FadeSlideTransition(
            animation: _formElementAnimation,
            // additionalOffset: fem,
            additionalOffset: 0.0,
            child: Column(
              children: [
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.licenseController,
                  editController: controller.editLicenseController,
                  formKey: _formKeyEditLicense,
                  header: TextConstant.license,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(TextConstant.speciality,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black.withOpacity(0.4),
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w400)),
                            ),
                            ElevatedButton(
                              onPressed: () {
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
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        final controller = Provider.of<
                                            DoctorProfileController>(context);
                                        return SizedBox(
                                          height: editModalHeight * fem,
                                          child: Focus(
                                              child: Container(
                                                // group167cge (455:270)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    25 * fem,
                                                    0 * fem,
                                                    5 * fem),
                                                padding: EdgeInsets.fromLTRB(
                                                    15 * fem,
                                                    0 * fem,
                                                    15 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12 * fem),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FadeSlideTransition(
                                                      animation:
                                                          _formElementAnimation,
                                                      additionalOffset:
                                                          2 * space,
                                                      child: Container(
                                                        // emailidwU2 (455:267)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                6 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                3 * fem),
                                                        child: Text(
                                                          TextConstant
                                                              .editSpeciality,
                                                          style: TextStyle(
                                                            // 'Work Sans',
                                                            fontFamily:
                                                                'DM Sans',
                                                            letterSpacing: 0.5,
                                                            fontSize: 14 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.1725 *
                                                                ffem /
                                                                fem,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                      height: 5 * fem,
                                                    ),
                                                    FadeSlideTransition(
                                                      animation:
                                                          _formElementAnimation,
                                                      additionalOffset:
                                                          2 * space,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .ECEBFF,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: ButtonTheme(
                                                            buttonColor:
                                                                AppColors
                                                                    .ECEBFF,
                                                            alignedDropdown:
                                                                true,
                                                            child:
                                                                DropdownButton(
                                                              underline:
                                                                  SizedBox(),
                                                              dropdownColor:
                                                                  AppColors
                                                                      .ECEBFF,
                                                              icon: const Icon(Icons
                                                                  .keyboard_arrow_down),
                                                              isExpanded: true,
                                                              elevation: 2,
                                                              hint: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    TextConstant
                                                                        .selectFromBelow),
                                                              ),
                                                              value: controller
                                                                  .editSpecialityDropdownValue,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              items: controller
                                                                  .specialityTypeDropDown
                                                                  .map((data) {
                                                                return DropdownMenuItem(
                                                                    value: data,
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            data,
                                                                            style:
                                                                                TextStyle(fontFamily: 'DM Sans', fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ));
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .setspecialityTypeValue(
                                                                        value
                                                                            .toString());
                                                              },
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                      height: 10 * fem,
                                                    ),
                                                    FadeSlideTransition(
                                                        animation:
                                                            _formElementAnimation,
                                                        additionalOffset:
                                                            2 * space,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.2,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5 *
                                                                            fem),
                                                                    color: AppColors
                                                                        .white),
                                                                child: Text(
                                                                  TextConstant
                                                                      .cancel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontSize:
                                                                          14 *
                                                                              fem,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .handleSubmition(
                                                                        context,
                                                                        'Speciality');
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        0 * fem,
                                                                        15 *
                                                                            fem,
                                                                        0 * fem,
                                                                        15 *
                                                                            fem),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.2,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5 *
                                                                            fem),
                                                                    color: AppColors
                                                                        .ECEBFF),
                                                                child: Text(
                                                                  TextConstant
                                                                      .submit,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: AppColors
                                                                          .primaryPurple,
                                                                      fontSize:
                                                                          14 *
                                                                              fem,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              onFocusChange: (value) {}),
                                        );
                                      });
                                    });
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
                                      borderRadius:
                                          BorderRadius.circular(6 * fem))),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 0 * fem, 0 * fem, 10 * fem),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.ECEBFF,
                                      width: 2 * fem))),
                          child: Container(
                            width: double.infinity,
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     2.3,
                            // constraints: BoxConstraints(
                            //   maxWidth:
                            //       MediaQuery.of(context)
                            //               .size
                            //               .width /
                            //           2.6,
                            // ),
                            child: Text(
                                controller.editSpecialityDropdownValue
                                    .toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black.withOpacity(0.8),
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400)),
                          ))
                    ]),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.clinicController,
                  editController: controller.editClinicController,
                  formKey: _formKeyEditClinicName,
                  header: TextConstant.clinicName,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.buisnessEntityController,
                  editController: controller.editBuisnessEntityController,
                  formKey: _formKeyEditBuisnessEntity,
                  header: TextConstant.businessEntity,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(TextConstant.typeEntity,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black.withOpacity(0.4),
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w400)),
                            ),
                            ElevatedButton(
                              onPressed: () {
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
                                      return StatefulBuilder(builder:
                                          (BuildContext context,
                                              StateSetter setState) {
                                        final controller = Provider.of<
                                            DoctorProfileController>(context);
                                        return SizedBox(
                                          height: editModalHeight * fem,
                                          child: Focus(
                                              child: Container(
                                                // group167cge (455:270)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    25 * fem,
                                                    0 * fem,
                                                    5 * fem),
                                                padding: EdgeInsets.fromLTRB(
                                                    15 * fem,
                                                    0 * fem,
                                                    15 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12 * fem),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    FadeSlideTransition(
                                                      animation:
                                                          _formElementAnimation,
                                                      additionalOffset:
                                                          2 * space,
                                                      child: Container(
                                                        // emailidwU2 (455:267)
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                6 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                3 * fem),
                                                        child: Text(
                                                          TextConstant
                                                              .editEntity,
                                                          style: TextStyle(
                                                            // 'Work Sans',
                                                            fontFamily:
                                                                'DM Sans',
                                                            letterSpacing: 0.5,
                                                            fontSize: 14 * ffem,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.1725 *
                                                                ffem /
                                                                fem,
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.8),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                      height: 5 * fem,
                                                    ),
                                                    FadeSlideTransition(
                                                      animation:
                                                          _formElementAnimation,
                                                      additionalOffset:
                                                          2 * space,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: AppColors
                                                                .ECEBFF,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: ButtonTheme(
                                                            buttonColor:
                                                                AppColors
                                                                    .ECEBFF,
                                                            alignedDropdown:
                                                                true,
                                                            child:
                                                                DropdownButton(
                                                              underline:
                                                                  SizedBox(),
                                                              dropdownColor:
                                                                  AppColors
                                                                      .ECEBFF,
                                                              icon: const Icon(Icons
                                                                  .keyboard_arrow_down),
                                                              isExpanded: true,
                                                              elevation: 2,
                                                              hint: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                    TextConstant
                                                                        .selectFromBelow),
                                                              ),
                                                              value: controller
                                                                  .editEntityDropdownValue,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleMedium,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12.0),
                                                              items: controller
                                                                  .entityTypeDropDown
                                                                  .map((data) {
                                                                return DropdownMenuItem(
                                                                    value: data,
                                                                    child: Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Text(
                                                                            data,
                                                                            style:
                                                                                TextStyle(fontFamily: 'DM Sans', fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ));
                                                              }).toList(),
                                                              onChanged:
                                                                  (value) {
                                                                controller
                                                                    .setentityTypeValue(
                                                                        value
                                                                            .toString());
                                                              },
                                                            )),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                      height: 10 * fem,
                                                    ),
                                                    FadeSlideTransition(
                                                        animation:
                                                            _formElementAnimation,
                                                        additionalOffset:
                                                            2 * space,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.2,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5 *
                                                                            fem),
                                                                    color: AppColors
                                                                        .white),
                                                                child: Text(
                                                                  TextConstant
                                                                      .cancel,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontSize:
                                                                          14 *
                                                                              fem,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                controller
                                                                    .handleSubmition(
                                                                        context,
                                                                        'Entity');
                                                              },
                                                              child: Container(
                                                                padding: EdgeInsets
                                                                    .fromLTRB(
                                                                        0 * fem,
                                                                        15 *
                                                                            fem,
                                                                        0 * fem,
                                                                        15 *
                                                                            fem),
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2.2,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(5 *
                                                                            fem),
                                                                    color: AppColors
                                                                        .ECEBFF),
                                                                child: Text(
                                                                  TextConstant
                                                                      .submit,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'DM Sans',
                                                                      color: AppColors
                                                                          .primaryPurple,
                                                                      fontSize:
                                                                          14 *
                                                                              fem,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                ),
                                              ),
                                              onFocusChange: (value) {}),
                                        );
                                      });
                                    });
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
                                      borderRadius:
                                          BorderRadius.circular(6 * fem))),
                            )
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.fromLTRB(
                              10 * fem, 0 * fem, 0 * fem, 10 * fem),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: AppColors.ECEBFF,
                                      width: 2 * fem))),
                          child: Container(
                            width: double.infinity,
                            // width: MediaQuery.of(context)
                            //         .size
                            //         .width /
                            //     2.3,
                            // constraints: BoxConstraints(
                            //   maxWidth:
                            //       MediaQuery.of(context)
                            //               .size
                            //               .width /
                            //           2.6,
                            // ),
                            child: Text(
                                controller.entityDropdownValue.toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black.withOpacity(0.8),
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400)),
                          ))
                    ]),
              ],
            )));
  }
}
