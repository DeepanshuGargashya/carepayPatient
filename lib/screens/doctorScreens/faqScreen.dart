import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/faqController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:provider/provider.dart';

class FaqScreen extends StatefulWidget {
  String element = "";
  FaqScreen([this.element = ""]);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FaqState();
  }
}

class FaqState extends State<FaqScreen> with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;

  final _postQuestion = GlobalKey<FormState>();

  var arrQuestions = [
    TextConstant.howMuch,
    TextConstant.whatAre,
    TextConstant.isLoan,
    TextConstant.anyChanges,
    TextConstant.theLoan,
    TextConstant.howDoes,
    TextConstant.whatsThe,
    TextConstant.isThere
  ];

  var arrAnswers = [
    TextConstant.takesLess,
    TextConstant.youHaveTo,
    TextConstant.weWork,
    TextConstant.yes,
    TextConstant.itDepends,
    TextConstant.repayment,
    TextConstant.patients,
    TextConstant.no
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<FaqController>(context, listen: false);
      fetchData.initFetchData(context,
          widget.element.length > 3 ? arrQuestions.indexOf(widget.element) : 0);
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

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FaqController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Row(
              mainAxisAlignment: controller.authenticate
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.start,
              children: [
                Text(
                  TextConstant.faqs,
                  style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                ),
                Visibility(
                  visible: controller.authenticate,
                  child: Container(
                      child: ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          isDismissible: true,
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
                            return SizedBox(
                              height: 290 * fem +
                                  MediaQuery.of(context).viewInsets.bottom,
                              child: Focus(
                                child: Container(
                                    // group167cge (455:270)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 25 * fem, 0 * fem, 5 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        15 * fem, 0 * fem, 15 * fem, 0 * fem),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(12 * fem),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(TextConstant.postAQuestion,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontFamily: 'DM Sans')),
                                        SizedBox(height: 5 * fem),
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 2,
                                                      color: AppColors.black
                                                          .withOpacity(0.1)))),
                                          width: double.infinity,
                                          padding: EdgeInsets.only(
                                              left: 8 * fem, right: 8 * fem),
                                        ),
                                        SizedBox(height: 20 * fem),
                                        Text(TextConstant.writeYour,
                                            style: TextStyle(
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontFamily: 'DM Sans',
                                                fontWeight: FontWeight.w700)),
                                        // SizedBox(height:5*fem),
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Form(
                                            key: _postQuestion,
                                            child: TextFormField(
                                              controller: controller.query,
                                              maxLines: 3,
                                              onChanged: (value) {
                                                if (value.length > 8) {
                                                  _postQuestion.currentState!
                                                      .validate();
                                                }
                                              },
                                              decoration: InputDecoration(
                                                  fillColor: AppColors.ECEBFF,
                                                  filled: true,
                                                  hintText:
                                                      TextConstant.typeHere,
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4 * fem),
                                                      borderSide:
                                                          BorderSide.none)),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  // [+]*[(]{0,1}[0-9]{1,4}[)]{0,1}+$[-\s\./0-9]

                                                  return TextConstant
                                                      .askQuestion;
                                                } else {
                                                  return null;
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15 * fem),
                                        Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 0, right: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0,
                                                                15 * fem,
                                                                0,
                                                                15 * fem),
                                                        child: Text(
                                                          TextConstant
                                                              .postAQuestion,
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .white,
                                                              fontFamily:
                                                                  'DM Sans',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize:
                                                                  14 * fem),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        if (_postQuestion
                                                            .currentState!
                                                            .validate()) {
                                                          controller
                                                              .handleSubmition(
                                                                  context);
                                                        } else {
                                                          _postQuestion
                                                              .currentState!
                                                              .validate();
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              elevation: 0,
                                                              primary: AppColors
                                                                  .primaryPurple,

                                                              // fixedSize: Size(380, 50),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(4 *
                                                                              fem)))),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                                // onFocusChange: (value) {
                                //   print(value);
                                //   if (value) {
                                //     controller.setEditModalHeight(
                                //         (MediaQuery.of(context).size.height / 1.6)
                                //             .toInt());
                                //   } else {
                                //     if (widget.editHeader == TextConstant.pincode &&
                                //         !controller.loading) {
                                //       controller.setpreviousToEdit("pincode");
                                //     } else if (widget.editHeader == TextConstant.ifsc &&
                                //         !controller.loading) {
                                //       controller.setpreviousToEdit("ifsc");
                                //     }
                                //     controller.setEditModalHeight(200.toInt());
                                //   }
                                // },
                              ),
                            );
                          });
                    },
                    child: Text(TextConstant.postQuestion,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: AppColors.secondaryOrange,
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w700)),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        side: BorderSide(
                            color: AppColors.secondaryOrange, width: 2),
                        backgroundColor: AppColors.tertiaryOrange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                                topRight: Radius.circular(6),
                                bottomLeft: Radius.circular(6)))),
                  )),
                ),
              ],
            ),
            elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(color: AppColors.white),
            ),
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0 * fem),
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            15 * fem, 0 * fem, 15 * fem, 0 * fem),
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 0.0,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/thinkEmoji.png',
                                  width: 24 * fem,
                                  height: 24 * fem,
                                ),
                                SizedBox(
                                  width: 8 * fem,
                                  height: 1,
                                ),
                                Text(
                                  TextConstant.questions,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14 * fem,
                                      color: AppColors.black.withOpacity(0.8)),
                                )
                              ],
                            )),
                      ),

                      Container(
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
                          child: Container(
                              // emailidwU2 (455:267)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 10 * fem, 0 * fem, 3 * fem),
                              child: Container(
                                height: 80 * fem,
                                child: ListView(
                                  controller: controller.scrollController,
                                  scrollDirection: Axis.horizontal,
                                  dragStartBehavior: DragStartBehavior.start,
                                  children: [
                                    for (int i = 0;
                                        i < arrQuestions.length;
                                        i++) ...[
                                      InkWell(
                                        onTap: () {
                                          controller.setvalue(i);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(10 * fem,
                                              0 * fem, 10 * fem, 0 * fem),
                                          padding: EdgeInsets.fromLTRB(20 * fem,
                                              0 * fem, 20 * fem, 0 * fem),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.4,
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors
                                                        .primaryPurple
                                                        .withOpacity(0.7),
                                                    blurRadius: 0.0,
                                                    spreadRadius: 0.0,
                                                    offset:
                                                        controller.index == i
                                                            ? Offset(
                                                                0.0, // Move to right 7.0 horizontally
                                                                -6.0, // Move to bottom 8.0 Vertically
                                                              )
                                                            : Offset(
                                                                0.0, // Move to right 7.0 horizontally
                                                                0.0, // Move to bottom 8.0 Vertically
                                                              ))
                                              ],
                                              // gradient: LinearGradient(colors: [
                                              // AppColors.white.withOpacity(0.1),
                                              // AppColors.white.withOpacity(0.1),
                                              color: AppColors.primaryPurple
                                                  .withOpacity(0.3),
                                              // ]),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10 * fem)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                arrQuestions[i].toString(),
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: 'DM Sans',
                                                    color: AppColors.white,
                                                    fontSize: 14 * fem,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ]
                                  ],
                                ),
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            15 * fem, 0 * fem, 15 * fem, 0 * fem),
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 0.0,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/icOwl.png',
                                  width: 24,
                                  height: 24,
                                ),
                                SizedBox(
                                  width: 8 * fem,
                                  height: 1,
                                ),
                                Text(
                                  TextConstant.answer,
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14 * fem,
                                      color: AppColors.black.withOpacity(0.8)),
                                )
                              ],
                            )),
                      ),

                      // Container(
                      //   // group167cge (455:270)
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      //   width: double.infinity,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12 * fem),
                      //   ),
                      //   child: FadeSlideTransition(
                      //     animation: _formElementAnimation,
                      //     // additionalOffset: fem,
                      //     additionalOffset: 0.0,
                      //     child: Container(
                      //       // emailidwU2 (455:267)
                      //         margin: EdgeInsets.fromLTRB(
                      //             0 * fem, 10 * fem, 0 * fem, 3 * fem),
                      //         child: Container(
                      //           height : MediaQuery.of(context).size.height/2.9,
                      //           // height: 80 * fem,
                      //           child: ListView(
                      //             scrollDirection: Axis.horizontal,
                      //             dragStartBehavior: DragStartBehavior.start,
                      //             children: [
                      //               for (int i = 0; i < arrAnswers.length; i++) ...[
                      //                 Container(
                      //                   margin: EdgeInsets.fromLTRB(
                      //                       10 * fem, 0 * fem, 10 * fem, 0 * fem),
                      //                   padding: EdgeInsets.fromLTRB(
                      //                       20 * fem, 0 * fem, 20 * fem, 0 * fem),
                      //                   width: MediaQuery.of(context).size.width /
                      //                       1.4,
                      //                   decoration: BoxDecoration(
                      //                     // gradient: LinearGradient(colors: [
                      //                     // AppColors.white.withOpacity(0.1),
                      //                     // AppColors.white.withOpacity(0.1),
                      //                     //   color: AppColors.primaryPurple
                      //                     //       .withOpacity(0.5 * fem),
                      //                       // ]),
                      //                       borderRadius:
                      //                       BorderRadius.circular(10 * fem)),
                      //                   child: Column(
                      //                     mainAxisAlignment:
                      //                     MainAxisAlignment.center,
                      //                     crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                     children: [
                      //                       Text(
                      //                         arrAnswers[i].toString(),
                      //                         textAlign: TextAlign.start,
                      //                         style: TextStyle(
                      //                             color: AppColors.black,
                      //                             fontSize: 14 * fem,
                      //                             fontWeight: FontWeight.w500),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ]
                      //             ],
                      //           ),
                      //         )),
                      //   ),
                      // ),

                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 20 * fem, 0 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            20 * fem, 0 * fem, 20 * fem, 0 * fem),
                        child: FadeSlideTransition(
                            animation: _formElementAnimation,
                            additionalOffset: 0.0,
                            child: Column(
                              children: [
                                Text(
                                  arrAnswers[controller.index].toString(),
                                  style: TextStyle(
                                      fontFamily: 'DM Sans',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14 * fem,
                                      height: 1.4 * fem / fem,
                                      // color: AppColors.white,
                                      letterSpacing: 0.5,
                                      color: AppColors.black.withOpacity(0.8)),
                                )
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 1,
                        height: 15 * fem,
                      ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 10 * fem, 0 * fem, 0 * fem),
                      //   padding: EdgeInsets.fromLTRB(
                      //       15 * fem, 0 * fem, 15 * fem, 0 * fem),
                      //   child: FadeSlideTransition(
                      //       animation: _formElementAnimation,
                      //       additionalOffset: 0.0,
                      //       child: Row(
                      //         children: [
                      //           Image.asset('assets/images/icSatisfy.png'),
                      //           SizedBox(
                      //             width: 8 * fem,
                      //             height: 1,
                      //           ),
                      //           TextButton(
                      //             // onPressed: enableResend ? _resendCode : null,
                      //             onPressed: () {},
                      //             child: Text(
                      //               TextConstant.satisfactory,
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(fontFamily: 'DM Sans',
                      //                 decoration: TextDecoration.underline,
                      //                 decorationColor: AppColors.primaryPurple,
                      //                 shadows: <Shadow>[
                      //                   Shadow(
                      //                     offset: Offset(0.0, -2.0),
                      //                     blurRadius: 0.0,
                      //                     color: AppColors.primaryPurple,
                      //                   ),
                      //                 ],
                      //                 // 'Work Sans',
                      //                 fontSize: 14 * ffem,
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.1725 * ffem / fem,
                      //                 color: Colors.transparent,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(
                      //       0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      //   padding: EdgeInsets.fromLTRB(
                      //       15 * fem, 0 * fem, 15 * fem, 0 * fem),
                      //   child: FadeSlideTransition(
                      //       animation: _formElementAnimation,
                      //       additionalOffset: 0.0,
                      //       child: Row(
                      //         children: [
                      //           Image.asset('assets/images/icNotSatisfy.png'),
                      //           SizedBox(
                      //             width: 8 * fem,
                      //             height: 1,
                      //           ),
                      //           TextButton(
                      //             // onPressed: enableResend ? _resendCode : null,
                      //             onPressed: () {},
                      //             child: Text(
                      //               TextConstant.didnt,
                      //               textAlign: TextAlign.center,
                      //               style: TextStyle(fontFamily: 'DM Sans',
                      //                 decoration: TextDecoration.underline,
                      //                 decorationColor: AppColors.primaryPurple,
                      //                 shadows: <Shadow>[
                      //                   Shadow(
                      //                     offset: Offset(0.0, -2.0),
                      //                     blurRadius: 0.0,
                      //                     color: AppColors.primaryPurple,
                      //                   ),
                      //                 ],
                      //                 // 'Work Sans',
                      //                 fontSize: 14 * ffem,
                      //                 fontWeight: FontWeight.w500,
                      //                 height: 1.1725 * ffem / fem,
                      //                 color: Colors.transparent,
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       )),
                      // ),
                    ],
                  ))))),
    );
  }
}
