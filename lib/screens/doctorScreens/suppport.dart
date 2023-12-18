import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/chatSupport.dart';
import 'package:flutter/material.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

class supportScreen extends StatefulWidget {
  const supportScreen({Key? key}) : super(key: key);

  @override
  State<supportScreen> createState() => _supportState();
}

class _supportState extends State<supportScreen>
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
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          leadingWidth: 12 * fem,
          backgroundColor: Colors.white,
          title: SizedBox(
            width: 143 * fem,
            height: 61 * fem,
            child: Image.asset('assets/images/carePayLogo.png'),
          ),
        ),
        body: SafeArea(
            child: Padding(
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              20 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.27,
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                FadeSlideTransition(
                                  additionalOffset: 0.0,
                                  animation: _formElementAnimation,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.tertiaryGreen,
                                        borderRadius: BorderRadius.only(
                                            bottomLeft:
                                                Radius.circular(14 * fem),
                                            bottomRight:
                                                Radius.circular(14 * fem))),
                                    width: MediaQuery.of(context).size.width,
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 1,
                                          height: 20 * fem,
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              10 * fem, 0 * fem, 10 * fem),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.8,
                                          child: Text(TextConstant.needHelp,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  color: AppColors.black
                                                      .withOpacity(0.8),
                                                  height: 1.2 * fem,
                                                  fontSize: 14 * fem,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              10 * fem, 0 * fem, 10 * fem),
                                          child: Text(
                                            TextConstant.helpYou,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.primaryGreen
                                                    .withOpacity(0.4),
                                                fontSize: 24 * fem,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              10 * fem, 0 * fem, 10 * fem),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.7,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem,
                                                      0 * fem),
                                                  shape: StadiumBorder(),
                                                  primary: Colors.transparent,
                                                  onSurface: Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  backgroundColor:
                                                      AppColors.white),
                                              onPressed: () async {
                                                Uri phoneno =
                                                    Uri.parse('tel:7503522316');
                                                if (await launchUrl(phoneno)) {
                                                  //dialer opened
                                                } else {
                                                  //dailer is not opened
                                                }
                                              },
                                              child: Container(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.center,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      8 * fem,
                                                      0 * fem,
                                                      8 * fem),
                                                  // width: MediaQuery.of(context)
                                                  //         .size
                                                  //         .width /
                                                  //     3,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color: AppColors
                                                            .primaryGreen,
                                                      ),
                                                      SizedBox(
                                                        width: 7 * fem,
                                                        height: 1,
                                                      ),
                                                      Text(
                                                        TextConstant.call,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          // 'Work Sans',
                                                          fontSize: 14 * fem,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height: 1.1725 *
                                                              fem /
                                                              fem,
                                                          color: AppColors
                                                              .primaryGreen,
                                                          letterSpacing: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              10 * fem, 0 * fem, 10 * fem),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              FadeSlideTransition(
                                                  animation:
                                                      _formElementAnimation,
                                                  additionalOffset: 0.0,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.1,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            20 * fem,
                                                            20 * fem,
                                                            20 * fem,
                                                            20 * fem),
                                                    decoration: BoxDecoration(
                                                        color: AppColors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    16 * fem)),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                              Icons.chat,
                                                              color: AppColors
                                                                  .primaryGreen,
                                                              size: 16 * fem,
                                                            ),
                                                            SizedBox(
                                                              width: 10 * fem,
                                                              height: 1,
                                                            ),
                                                            Text(
                                                              TextConstant.chat,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'DM Sans',
                                                                  fontSize:
                                                                      14 * fem,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: AppColors
                                                                      .primaryGreen),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 1,
                                                          height: 10 * fem,
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  10 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 2 *
                                                                          fem,
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2)))),
                                                          child: Text(
                                                            TextConstant
                                                                .option1,
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: AppColors
                                                                    .primaryGreen,
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  10 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 2 *
                                                                          fem,
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2)))),
                                                          child: Text(
                                                            'Option 2',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: AppColors
                                                                    .primaryGreen,
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  10 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 2 *
                                                                          fem,
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2)))),
                                                          child: Text(
                                                            'Option 3',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: AppColors
                                                                    .primaryGreen,
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  10 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 2 *
                                                                          fem,
                                                                      color: AppColors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.2)))),
                                                          child: Text(
                                                            'Option 4',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: AppColors
                                                                    .primaryGreen,
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  10 * fem,
                                                                  0 * fem,
                                                                  10 * fem),
                                                          decoration: BoxDecoration(
                                                              border: Border(
                                                                  bottom: BorderSide(
                                                                      width: 0 *
                                                                          fem,
                                                                      color: AppColors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.2)))),
                                                          child: Text(
                                                            'other',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                color: AppColors
                                                                    .primaryGreen,
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 0 * fem, 10 * fem, 0 * fem),
                                    // group167cge (455:270)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 10 * fem, 0 * fem, 15 * fem),
                                    width: double.infinity,
                                    child: FadeSlideTransition(
                                        animation: _formElementAnimation,
                                        // additionalOffset: fem,
                                        additionalOffset: 0.0,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(
                                                    icon: Image.asset(
                                                      'assets/images/chatBubbleIcon.png',
                                                    ),
                                                    iconSize: 30 * fem,
                                                    onPressed: () {},
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                    height: 1,
                                                  ),
                                                  Text(
                                                    TextConstant.chatThreads,
                                                    style: TextStyle(
                                                        fontFamily: 'DM Sans',
                                                        fontSize: 14 * fem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors.black
                                                            .withOpacity(0.8)),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.2),
                                                            width: 1 * fem))),
                                                padding: EdgeInsets.fromLTRB(
                                                    10 * fem,
                                                    15 * fem,
                                                    10 * fem,
                                                    15 * fem),
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    15 * fem,
                                                    0 * fem,
                                                    15 * fem),
                                                child: FadeSlideTransition(
                                                  additionalOffset: 0.0,
                                                  animation:
                                                      _formElementAnimation,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text.rich(TextSpan(
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      '14/04/2023,',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    // 'Work Sans',

                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontSize:
                                                                        12 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.1725 *
                                                                            ffem /
                                                                            fem,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      ' 09:29 AM',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    // 'Work Sans',
                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontSize:
                                                                        12 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.1725 *
                                                                            ffem /
                                                                            fem,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                              ])),
                                                          Text(
                                                            TextConstant.open,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              letterSpacing:
                                                                  0.5,
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height: 1.1725 *
                                                                  ffem /
                                                                  fem,
                                                              color: AppColors
                                                                  .primaryPurple,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                        height: 15 * fem,
                                                      ),
                                                      Text(
                                                        'Loan not disbursed.',
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          letterSpacing: 0.5,
                                                          fontSize: 12 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.1725 *
                                                              ffem /
                                                              fem,
                                                          color: AppColors.black
                                                              .withOpacity(0.8),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color: AppColors
                                                                .black
                                                                .withOpacity(
                                                                    0.2),
                                                            width: 1 * fem))),
                                                padding: EdgeInsets.fromLTRB(
                                                    10 * fem,
                                                    15 * fem,
                                                    10 * fem,
                                                    15 * fem),
                                                child: FadeSlideTransition(
                                                  additionalOffset: 0.0,
                                                  animation:
                                                      _formElementAnimation,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text.rich(TextSpan(
                                                              children: <InlineSpan>[
                                                                TextSpan(
                                                                  text:
                                                                      '14/04/2023,',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    // 'Work Sans',

                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontSize:
                                                                        12 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.1725 *
                                                                            ffem /
                                                                            fem,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                  ),
                                                                ),
                                                                TextSpan(
                                                                  text:
                                                                      ' 09:29 AM',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'DM Sans',
                                                                    // 'Work Sans',
                                                                    letterSpacing:
                                                                        0.5,
                                                                    fontSize:
                                                                        12 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.1725 *
                                                                            ffem /
                                                                            fem,
                                                                    color: AppColors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.4),
                                                                  ),
                                                                ),
                                                              ])),
                                                          Text(
                                                            TextConstant.open,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'DM Sans',
                                                              letterSpacing:
                                                                  0.5,
                                                              fontSize:
                                                                  12 * ffem,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              height: 1.1725 *
                                                                  ffem /
                                                                  fem,
                                                              color: AppColors
                                                                  .primaryPurple,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        width: 1,
                                                        height: 15 * fem,
                                                      ),
                                                      Text(
                                                        'Loan not disbursed.',
                                                        style: TextStyle(
                                                          fontFamily: 'DM Sans',
                                                          letterSpacing: 0.5,
                                                          fontSize: 12 * ffem,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.1725 *
                                                              ffem /
                                                              fem,
                                                          color: AppColors.black
                                                              .withOpacity(0.8),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ]))),
                                Container(
                                    padding: EdgeInsets.fromLTRB(
                                        20 * fem, 0 * fem, 20 * fem, 0 * fem),
                                    // group167cge (455:270)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 20 * fem, 0 * fem, 0 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12 * fem),
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
                                                    color: AppColors
                                                        .secondaryOrange,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 24 * fem),
                                              ),
                                              SizedBox(
                                                width: 1,
                                                height: 15 * fem,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.3,
                                                child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                0 * fem,
                                                                0 * fem,
                                                                0 * fem),
                                                        shape: StadiumBorder(),
                                                        primary:
                                                            Colors.transparent,
                                                        onSurface:
                                                            Colors.transparent,
                                                        shadowColor:
                                                            Colors.transparent,
                                                        backgroundColor: AppColors
                                                            .secondaryOrange),
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
                                                    child: Container(
                                                      // mainAxisAlignment:
                                                      //     MainAxisAlignment.center,
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0 * fem,
                                                                8 * fem,
                                                                0 * fem,
                                                                8 * fem),
                                                        // width: MediaQuery.of(context)
                                                        //         .size
                                                        //         .width /
                                                        //     3,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.chat,
                                                              color: AppColors
                                                                  .white,
                                                            ),
                                                            SizedBox(
                                                              width: 7 * fem,
                                                              height: 1,
                                                            ),
                                                            Text(
                                                              TextConstant.chat,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'DM Sans',
                                                                // 'Work Sans',
                                                                fontSize:
                                                                    14 * fem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                height: 1.1725 *
                                                                    fem /
                                                                    fem,
                                                                color: AppColors
                                                                    .white,
                                                                letterSpacing:
                                                                    0.5,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              )
                                            ]))),
                              ],
                            ),
                          ),
                        )
                      ],
                    )))),
      ),
    );
  }
}
