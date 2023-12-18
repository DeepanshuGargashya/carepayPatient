import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:simple_animations/animation_builder/mirror_animation_builder.dart';
import 'package:CarePay/res/textConstant.dart';
import 'home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class thank_you extends StatefulWidget {
  @override
  State<thank_you> createState() => _thank_youState();
}

class _thank_youState extends State<thank_you>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  var nameController = TextEditingController();

  var numberValue;

  @override
  @override
  void initState() {
    getNumber();
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
          backgroundColor: AppColors.primaryPurple,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,200,0,0),
                    child: Center(
                      child: Container(
                        height:180,
                          width:180,
                          // padding: EdgeInsets.only(top: 200),
                          child: Image(
                            image: AssetImage('assets/images/logo.png'),
                          )),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: 60,
                        right: 60,
                        top: 42,
                      ),
                      child: Text(
                        TextConstant.underReview,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 36),
                      child: Text(
                        TextConstant.takesAround,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: AppColors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 60),
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
                            curve: Curves.easeInOutSine, // non-linear animation
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
                                      child: home()),
                                );
                              },
                              child: FadeSlideTransition(
                                animation: _formElementAnimation,
                                additionalOffset: space,
                                child: Container(
                                    // group167cge (455:270)
                                    padding: EdgeInsets.fromLTRB(
                                        5 * fem, 10 * fem, 5 * fem, 10 * fem),
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 15 * fem, 0 * fem, 10 * fem),
                                    width:
                                        MediaQuery.of(context).size.width / 2.6,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.transparent,
                                          blurRadius: 0,
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
                                      TextConstant.goToHome,
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
                            width: MediaQuery.of(context).size.width / 3.8,
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
          ),
        ),
      ),
    );
  }

  void getNumber() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    dynamic number = pref.getString('number');
    setState(() {
      numberValue = number;
      // nameController.text=number.toString();
    });
  }
}
