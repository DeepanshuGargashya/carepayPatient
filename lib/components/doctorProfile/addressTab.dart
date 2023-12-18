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

class AddressTabScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressTabState();
  }
}

class AddressTabState extends State<AddressTabScreen>
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
                  controller: controller.buildingController,
                  editController: controller.editBuildingController,
                  formKey: _formKeyEditBuilding,
                  header: TextConstant.building,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.localityController,
                  editController: controller.editLocalityController,
                  formKey: _formKeyEditLocality,
                  header: TextConstant.locality,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.pincodeController,
                  editController: controller.editPincodeController,
                  formKey: _formKeyEditPincode,
                  header: TextConstant.pincode,
                ),
                SizedBox(
                  width: 1,
                  height: 10 * fem,
                ),
                EachDetailWidget(
                  controller: controller.cityController,
                  editController: controller.editCityController,
                  formKey: _formKeyEditCity,
                  header: TextConstant.city,
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
                              child: Text(TextConstant.state,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      color: AppColors.black.withOpacity(0.4),
                                      fontSize: 12 * fem,
                                      fontWeight: FontWeight.w400)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Utils.toastMessage("Change PinCode");
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
                            //           1.9,
                            // ),
                            child: Text(
                                controller.stateDropdownValue.toString(),
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
