import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import '../../components/fade_slide_transition.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';
import 'instantLoanWelcome.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({Key? key}) : super(key: key);

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2>
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
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return SafeArea(
        child: Scaffold(
            // appBar:  AppBar(
            //   title: Column(
            //     children: [
            //     SizedBox(
            //
            //     height: 13 * fem,),
            //       SizedBox(
            //         width: 143 * fem,
            //         height: 61 * fem,
            //         child: Image.asset('assets/images/carePayLogo.png'),
            //       ),
            //     ],
            //   ),
            //   centerTitle: true,
            //   automaticallyImplyLeading: false,
            //   backgroundColor: AppColors.whiteColor,
            //   elevation: 0,
            // ),
            backgroundColor: AppColors.white,
            body: Padding(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: Container(
                            width: 155 * fem,
                            height: 70 * fem,
                            // group167cge (455:270)
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 15 * fem, 0 * fem, 10 * fem),
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 15 * fem, 0 * fem, 0 * fem),
                            // width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12 * fem),
                            ),
                            child: Image.asset('assets/images/carePayLogo.png'),
                          ),
                        ),
                        FadeSlideTransition(
                          animation: _formElementAnimation,
                          additionalOffset: space,
                          child: Container(
                              height: MediaQuery.of(context).size.height / 2.3,
                              // group167cge (455:270)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Image.asset('assets/images/icRetention.png'
                                  // : 'assets/images/icRetention.png'
                                  )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                // group167cge (455:270)
                                padding: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 5 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    additionalOffset: space,
                                    child: Text(
                                      // screen == 1
                                      TextConstant.increased,
                                      // : TextConstant.increased,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          height: 1.2 * fem,
                                          color: AppColors.primaryPurple,
                                          fontSize: 32 * fem,
                                          fontWeight: FontWeight.w700),
                                    ))),
                            Container(
                                // group167cge (455:270)
                                padding: EdgeInsets.fromLTRB(
                                    30 * fem, 0 * fem, 30 * fem, 0 * fem),
                                margin: EdgeInsets.fromLTRB(
                                    20 * fem, 5 * fem, 20 * fem, 5 * fem),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: FadeSlideTransition(
                                    animation: _formElementAnimation,
                                    additionalOffset: space,
                                    child: Text(
                                      // screen == 1
                                      TextConstant.enableYour,
                                      // : TextConstant.enableYour,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color: Colors.black,
                                          height: 1.26 * fem,
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w500),
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
                                      // if (screen < 2) {
                                      //   setState(() {
                                      //     screen += 1;
                                      //   });
                                      // } else {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType
                                                .rightToLeftWithFade,
                                            child: InstantLoanWelcomeScreen()),
                                      );
                                      // }
                                    },
                                    child: FadeSlideTransition(
                                      animation: _formElementAnimation,
                                      additionalOffset: space,
                                      child: Container(
                                          // group167cge (455:270)
                                          padding: EdgeInsets.fromLTRB(0 * fem,
                                              10 * fem, 0 * fem, 10 * fem),
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              40 * fem, 0 * fem, 10 * fem),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
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
                                            TextConstant.next,
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
                                Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 1 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ))));
  }
}
