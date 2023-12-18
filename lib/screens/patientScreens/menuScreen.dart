import 'package:CarePay/screens/patientScreens/dashboard.dart';
import 'package:CarePay/view_model/patientFlow/dashboardController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MenuState();
  }
}

class MenuState extends State<MenuScreen> with SingleTickerProviderStateMixin {
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

  Widget build(BuildContext context) {
    final controller = Provider.of<DashboardController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    var barHeight = Get.statusBarHeight;
    // TODO: implement build
    return Scaffold(
        backgroundColor: AppColors.primaryPurple,
        body: Padding(
          padding: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 0 * fem),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 1,
                  height: barHeight / 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/icMenuCarePay.png',
                      width: 143 * fem,
                      height: 61 * fem,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset('assets/images/icCancel.png'))
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: 70 * fem,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: Text(
                            TextConstant.dashbboard,
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              shadows: [
                                Shadow(
                                    color: AppColors.white,
                                    offset: Offset(0, -5))
                              ],
                              decoration: TextDecoration.underline,
                              fontSize: 24 * fem,
                              decorationColor: Colors.grey[350],
                              decorationThickness: 2,
                              fontWeight: FontWeight.w700,
                              color: AppColors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                          height: 20 * fem,
                        ),
                        InkWell(
                          child: Text(
                            TextConstant.payInstalllment,
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              shadows: [
                                Shadow(
                                    color: AppColors.white,
                                    offset: Offset(0, -5))
                              ],
                              // decoration: TextDecoration.underline,
                              fontSize: 24 * fem,
                              // decorationColor: Colors.grey[350],
                              // decorationThickness: 2,
                              fontWeight: FontWeight.w400,
                              color: AppColors.transparent,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                          height: 20 * fem,
                        ),
                        // InkWell(
                        //   child: Text(
                        //     TextConstant.contactSupport,
                        //     style: TextStyle(
                        //       fontFamily: 'DM Sans',
                        //       shadows: [
                        //         Shadow(
                        //             color: AppColors.white,
                        //             offset: Offset(0, -5))
                        //       ],
                        //       // decoration: TextDecoration.underline,
                        //       fontSize: 24 * fem,
                        //       // decorationColor: Colors.grey[350],
                        //       // decorationThickness: 2,
                        //       fontWeight: FontWeight.w400,
                        //       color: AppColors.transparent,
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    controller.handleLogout(context);
                  },
                  child: Text(
                    TextConstant.logOut,
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      shadows: [
                        Shadow(
                            color: AppColors.primaryOrange,
                            offset: Offset(0, -5))
                      ],
                      // decoration: TextDecoration.underline,
                      fontSize: 24 * fem,
                      // decorationColor: Colors.grey[350],
                      // decorationThickness: 2,
                      fontWeight: FontWeight.w600,
                      color: AppColors.transparent,
                    ),
                  ),
                ),
              ]),
        ));
  }
}
