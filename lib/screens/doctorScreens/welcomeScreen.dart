import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:CarePay/res/textConstant.dart';

class DoctorWelcomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorWelcomeState();
  }
}

class DoctorWelcomeState extends State<DoctorWelcomeScreen>
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
    // TODO: implement build
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.white,
              body: Padding(
                  padding: EdgeInsets.fromLTRB(
                      10 * fem, 10 * fem, 10 * fem, 0 * fem),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.15,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 1,
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        SizedBox(
                          width: 143 * fem,
                          height: 61 * fem,
                          child: Image.asset('assets/images/carePayLogo.png'),
                        ),
                        SizedBox(
                          width: 1,
                          height: MediaQuery.of(context).size.height / 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // group167cge (455:270)
                                padding: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    additionalOffset: space,
                                    child: Column(
                                      children: [
                                        Text(
                                          TextConstant.welcome,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              height: 1.2 * fem,
                                              color: AppColors.primaryPurple,
                                              fontSize: 32 * fem,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          TextConstant.toCarePay,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              height: 1.2 * fem,
                                              color: AppColors.primaryPurple,
                                              fontSize: 32 * fem,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ))),
                            Container(
                                // group167cge (455:270)
                                padding: EdgeInsets.fromLTRB(
                                    15 * fem, 0 * fem, 15 * fem, 0 * fem),
                                margin: EdgeInsets.fromLTRB(
                                    10 * fem, 5 * fem, 10 * fem, 15 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    additionalOffset: space,
                                    child: Text(
                                      TextConstant.clinicReady,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color: Colors.black,
                                          height: 1.26 * fem,
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400),
                                    ))),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                MirrorAnimationBuilder<double>(
                                  tween: Tween(
                                      begin: 0,
                                      end: 5), // value for offset x-coordinate
                                  duration: const Duration(seconds: 1),
                                  curve: Curves
                                      .easeInOutSine, // non-linear animation
                                  builder: (context, value, child) {
                                    return Transform.translate(
                                      offset: Offset(0,
                                          value), // use animated value for x-coordinate
                                      child: child,
                                    );
                                  },
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: details()),
                                      );
                                    },
                                    child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      additionalOffset: space,
                                      child: Container(
                                          // group167cge (455:270)
                                          padding: EdgeInsets.fromLTRB(5 * fem,
                                              10 * fem, 5 * fem, 10 * fem),
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              15 * fem, 0 * fem, 10 * fem),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.6,
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius: 5,
                                                offset: Offset(-5, 0),
                                              ),
                                            ],
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  AppColors.ECEBFF,
                                                  AppColors.DAD9E7,
                                                ]),
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                          ),
                                          child: Text(
                                            TextConstant.okay,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.primaryPurple,
                                                fontSize: 16 * fem,
                                                fontWeight: FontWeight.w700),
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 1,
                                  height: 15 * fem,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )))),
    );
  }
}
