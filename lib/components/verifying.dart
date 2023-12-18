import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:CarePay/components/fade_slide_transition.dart';

class VerifyingLoaderScreen extends StatefulWidget {
  var title;
  VerifyingLoaderScreen({required this.title});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VerifyingState();
  }
}

class VerifyingState extends State<VerifyingLoaderScreen>
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
    var barHeight = Get.statusBarHeight;

    return Scaffold(
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        width: 1,
        height: barHeight / 3,
      ),
      Container(
          // group167cge (455:270)
          padding: EdgeInsets.fromLTRB(15 * fem, 0 * fem, 15 * fem, 0 * fem),
          margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 10 * fem),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12 * fem),
          ),
          child: FadeSlideTransition(
              animation: _formElementAnimation,
              additionalOffset: space,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [Image.asset('assets/images/carePayLogo.png')],
              ))),
      Container(
          height: MediaQuery.of(context).size.height / 1.3,
          child: Padding(
              padding:
                  EdgeInsets.fromLTRB(10 * fem, 0 * fem, 10 * fem, 0 * fem),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeSlideTransition(
                      animation: _formElementAnimation,
                      // additionalOffset: fem,
                      additionalOffset: 0.0,
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset('assets/images/verifyingLoader.gif'),
                      ),
                    ),
                    SizedBox(
                      width: 2,
                      height: 8 * fem,
                    ),
                    FadeSlideTransition(
                      animation: _formElementAnimation,
                      // additionalOffset: fem,
                      additionalOffset: 0.0,
                      child: Text(
                        widget.title.toString(),
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Color(0xff514C9F),
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ])))
    ])));
  }
}
