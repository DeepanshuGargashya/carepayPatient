import 'package:CarePay/components/doctorProfile/addressTab.dart';
import 'package:CarePay/components/doctorProfile/bankTab.dart';
import 'package:CarePay/components/doctorProfile/documentsTab.dart';
import 'package:CarePay/components/doctorProfile/eachDetail.dart';
import 'package:CarePay/components/doctorProfile/personalTab.dart';
import 'package:CarePay/components/doctorProfile/practiceTab.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:CarePay/view_model/doctorFlow/doctorProfileController.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:CarePay/res/textConstant.dart';

class DoctorProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorProfileState();
  }
}

class DoctorProfileState extends State<DoctorProfileScreen>
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
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData =
          Provider.of<DoctorProfileController>(context, listen: false);
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
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              TextConstant.profile,
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
                controller.goBackController();
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: Colors.white),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(5 * fem, 0 * fem, 5 * fem, 0 * fem),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 10 * fem),
                        child: Text.rich(TextSpan(children: <InlineSpan>[
                          TextSpan(
                              text: TextConstant.sunshine,
                              style: TextStyle(
                                  fontFamily: 'DM Sans', fontSize: 18 * fem)),
                          TextSpan(
                            text: TextConstant.profileDetails,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.black.withOpacity(0.8),
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w500),
                          ),
                        ])),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                        // group167cge (455:270)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: FadeSlideTransition(
                          animation: _formElementAnimation,
                          // additionalOffset: fem,
                          additionalOffset: 0.0,
                          child: Container(
                              // emailidwU2 (455:267)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 10 * fem, 0 * fem, 1 * fem),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: controller.profileTab ==
                                                    TextConstant.personall
                                                ? 2.0
                                                : 0.0,
                                            color: controller.profileTab ==
                                                    TextConstant.personall
                                                ? AppColors.primaryPurple
                                                    .withOpacity(0.4)
                                                : AppColors.white),
                                      ),
                                    ),
                                    child: TextButton(
                                        onPressed: () {
                                          controller.setProfileTab(
                                              TextConstant.personall);
                                        },
                                        child: Text.rich(
                                            TextSpan(children: <InlineSpan>[
                                          TextSpan(
                                            text: TextConstant.personall,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: controller.profileTab ==
                                                        TextConstant.personall
                                                    ? AppColors.primaryPurple
                                                    : AppColors.black
                                                        .withOpacity(0.4),
                                                fontSize: 12 * fem,
                                                fontWeight: controller
                                                            .profileTab ==
                                                        TextConstant.personall
                                                    ? FontWeight.w500
                                                    : FontWeight.w400),
                                          ),
                                        ])),
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      5 * ffem)),
                                          primary: AppColors.primaryPurple,
                                          backgroundColor: Color.fromARGB(
                                              255, 253, 251, 251),
                                        )),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: controller.profileTab ==
                                                    TextConstant.address
                                                ? 2.0
                                                : 0.0,
                                            color: controller.profileTab ==
                                                    TextConstant.address
                                                ? AppColors.primaryPurple
                                                    .withOpacity(0.4)
                                                : AppColors.white),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.setProfileTab(
                                            TextConstant.address);
                                      },
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.addressTab,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: controller.profileTab ==
                                                      TextConstant.address
                                                  ? AppColors.primaryPurple
                                                  : AppColors.black
                                                      .withOpacity(0.4),
                                              fontSize: 12 * fem,
                                              fontWeight:
                                                  controller.profileTab ==
                                                          TextConstant.address
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                        ),
                                      ])),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5 * ffem)),
                                        primary: AppColors.primaryPurple,
                                        backgroundColor:
                                            Color.fromARGB(255, 253, 251, 251),
                                        // onSurface: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: controller.profileTab ==
                                                    TextConstant.practicee
                                                ? 2.0
                                                : 0.0,
                                            color: controller.profileTab ==
                                                    TextConstant.practicee
                                                ? AppColors.primaryPurple
                                                    .withOpacity(0.4)
                                                : AppColors.white),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.setProfileTab(
                                            TextConstant.practicee);
                                      },
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.practicee,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: controller.profileTab ==
                                                      TextConstant.practicee
                                                  ? AppColors.primaryPurple
                                                  : AppColors.black
                                                      .withOpacity(0.4),
                                              fontSize: 12 * fem,
                                              fontWeight:
                                                  controller.profileTab ==
                                                          TextConstant.practicee
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                        ),
                                      ])),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5 * ffem)),
                                        primary: AppColors.primaryPurple,
                                        backgroundColor:
                                            Color.fromARGB(255, 253, 251, 251),
                                        // onSurface: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: controller.profileTab ==
                                                    TextConstant.bank
                                                ? 2.0
                                                : 0.0,
                                            color: controller.profileTab ==
                                                    TextConstant.bank
                                                ? AppColors.primaryPurple
                                                    .withOpacity(0.4)
                                                : AppColors.white),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller
                                            .setProfileTab(TextConstant.bank);
                                      },
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.bank,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: controller.profileTab ==
                                                      TextConstant.bank
                                                  ? AppColors.primaryPurple
                                                  : AppColors.black
                                                      .withOpacity(0.4),
                                              fontSize: 12 * fem,
                                              fontWeight:
                                                  controller.profileTab ==
                                                          TextConstant.bank
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                        ),
                                      ])),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5 * ffem)),
                                        primary: AppColors.primaryPurple,
                                        backgroundColor:
                                            Color.fromARGB(255, 253, 251, 251),
                                        // onSurface: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            width: controller.profileTab ==
                                                    TextConstant.documents
                                                ? 2.0
                                                : 0.0,
                                            color: controller.profileTab ==
                                                    TextConstant.documents
                                                ? AppColors.primaryPurple
                                                    .withOpacity(0.4)
                                                : AppColors.white),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        controller.setProfileTab(
                                            TextConstant.documents);
                                      },
                                      child: Text.rich(
                                          TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: TextConstant.documents,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: controller.profileTab ==
                                                      TextConstant.documents
                                                  ? AppColors.primaryPurple
                                                  : AppColors.black
                                                      .withOpacity(0.4),
                                              fontSize: 12 * fem,
                                              fontWeight:
                                                  controller.profileTab ==
                                                          TextConstant.documents
                                                      ? FontWeight.w500
                                                      : FontWeight.w400),
                                        ),
                                      ])),
                                      style: TextButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                5 * ffem)),
                                        primary: AppColors.primaryPurple,
                                        backgroundColor:
                                            Color.fromARGB(255, 253, 251, 251),
                                        // onSurface: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      if (controller.profileTab == TextConstant.personall) ...[
                        PersonalTabScreen()
                      ] else if (controller.profileTab ==
                          TextConstant.address) ...[
                        AddressTabScreen()
                      ] else if (controller.profileTab ==
                          TextConstant.practiceTab) ...[
                        PracticeTabScreen()
                      ] else if (controller.profileTab ==
                          TextConstant.bank) ...[
                        BankTabScreen()
                      ] else if (controller.profileTab ==
                          TextConstant.documents) ...[
                        SizedBox(
                          width: 1,
                          height: 10 * fem,
                        ),
                        DocumentTabScreen()
                      ],
                      FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 1,
                              height: 30 * fem,
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                // group167cge (455:270)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 10 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    // additionalOffset: fem,
                                    additionalOffset: 0.0,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            TextConstant.advices,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black
                                                    .withOpacity(0.8),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14 * fem),
                                          ),
                                          SizedBox(
                                            width: 1,
                                            height: 10 * fem,
                                          ),
                                          Text(
                                            TextConstant.someAdvice,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color:
                                                    AppColors.secondaryOrange,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 24 * fem),
                                          ),
                                          SizedBox(
                                            width: 1,
                                            height: 15 * fem,
                                          ),
                                          Center(
                                            child: Container(
                                              height: 41,
                                              width: 170,
                                              // color: Colors.white,
                                              child: ElevatedButton.icon(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    PageTransition(
                                                        type: PageTransitionType
                                                            .rightToLeftWithFade,
                                                        child:
                                                            ChatSupportScreen()),
                                                  );
                                                },
                                                label: Text(
                                                  TextConstant.chat,
                                                  style: TextStyle(
                                                      fontFamily: 'DM Sans',
                                                      fontSize: 14 * fem,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: AppColors.white),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    shape: StadiumBorder(),
                                                    backgroundColor: AppColors
                                                        .secondaryOrange),
                                                icon: Icon(Icons.chat,
                                                    color: AppColors.white),
                                              ),
                                            ),
                                          ),
                                        ]))),
                            SizedBox(
                              width: 1,
                              height: 5 * fem,
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                // group167cge (455:270)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 20 * fem, 0 * fem, 0 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    controller.handleLogout();
                                  },
                                  child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      // additionalOffset: fem,
                                      additionalOffset: 0.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.power_settings_new_rounded,
                                            color: AppColors.primaryOrange,
                                            size: 18 * fem,
                                          ),
                                          SizedBox(
                                            width: 7 * fem,
                                            height: 1,
                                          ),
                                          Text(
                                            TextConstant.logout,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14 * fem,
                                                color: AppColors.primaryOrange),
                                          )
                                        ],
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(width: 1, height: 20 * fem)
                    ],
                  ))))),
    );
  }
}
