import 'package:CarePay/components/aiAssistant/eachResult.dart';
import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/aiAssistantController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AIAssistant extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AIAssistantState();
  }
}

class AIAssistantState extends State<AIAssistant>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
  final description = GlobalKey<FormState>();
  TextEditingController descriptions = TextEditingController();
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   var fetchData =
    //       Provider.of<AllTransactionController>(context, listen: false);
    //   fetchData.initFetchData(context);
    // });
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
    final controller = Provider.of<AIAssistantController>(context);
    // TODO: implement build
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Text(
                "AI Assistant",
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 18 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(0.8)),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(10 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                    color: AppColors.tertiaryOrange,
                    borderRadius: BorderRadius.circular(4 * fem)),
                padding:
                    EdgeInsets.fromLTRB(2 * fem, 5 * fem, 2 * fem, 5 * fem),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/coinIcon.png"),
                    SizedBox(
                      width: 8 * fem,
                      height: 1,
                    ),
                    Text(
                      "500",
                      style: TextStyle(
                          fontSize: 12 * fem,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'DM Sans',
                          color: AppColors.primaryOrange),
                    )
                  ],
                ),
              )
            ],
          ),
          actions: [
            Row(
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(5 * fem, 0 * fem, 5 * fem, 0 * fem),
                  width: 28 * fem,
                  height: 28 * fem,
                  decoration: BoxDecoration(color: AppColors.tertiaryOrange),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/saveIcon.png",
                        width: 14 * fem,
                        height: 22 * fem,
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.red,
                  width: 34 * fem,
                  height: 34 * fem,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset(
                        'assets/images/X.png',
                        width: 48 * fem,
                        height: 48 * fem,
                      )),
                ),
              ],
            )
          ],
          elevation: 0,
          leading: null,
          flexibleSpace: Container(
            decoration: BoxDecoration(color: AppColors.white),
          ),
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 0 * fem),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                  child: FadeSlideTransition(
                    additionalOffset: space,
                    animation: _formElementAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                              "Enter a clinical problem representation below",
                              style: TextStyle(
                                fontSize: 14 * fem,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Form(
                            key: description,
                            child: TextFormField(
                              controller: descriptions,
                              keyboardType: TextInputType.multiline,
                              minLines: 3,
                              maxLines: 5,
                              decoration: InputDecoration(
                                fillColor: AppColors.white,
                                filled: true,
                                hintText: "",
                                // border:
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem),
                                    borderSide: BorderSide(
                                        color: AppColors.black.withOpacity(0.2),
                                        width: 1 * fem)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.black.withOpacity(0.2),
                                        width: 1 * fem)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: AppColors.primaryPurple
                                            .withOpacity(0.8),
                                        width: 1 * fem)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
                  child: FadeSlideTransition(
                    additionalOffset: space,
                    animation: _formElementAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 5 * fem, 0 * fem, 5 * fem),
                          child: Text(
                            'What would you like AI to assist with?',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'DM Sans'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 0 * fem),
                          child: Text(
                            'you can select multiple options',
                            style: TextStyle(
                                color: AppColors.black,
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'DM Sans'),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 10 * fem, 0 * fem, 10 * fem),
                          child: Column(children: [
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: 2 * space,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 0, 10 * fem, 0),
                                // margin: EdgeInsets.only(right: 200),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      child: Checkbox(
                                          activeColor: AppColors.primaryPurple
                                              .withOpacity(0.1),
                                          checkColor: AppColors.primaryPurple,
                                          value: controller.isDiagnosisChecked,
                                          onChanged: (bool? newValue) {
                                            controller.isCheckedPerform(
                                                newValue, "diagnosis");
                                          }),
                                    ),
                                    SizedBox(
                                      width: 10 * fem,
                                      height: 1,
                                    ),
                                    Container(
                                      child: Text(
                                        "Differential Diagnosis",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 * fem,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: 2 * space,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 0, 10 * fem, 0),
                                // margin: EdgeInsets.only(right: 200),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      child: Checkbox(
                                          activeColor: AppColors.primaryPurple
                                              .withOpacity(0.1),
                                          checkColor: AppColors.primaryPurple,
                                          value:
                                              controller.isClinicalPlanChecked,
                                          onChanged: (bool? newValue) {
                                            controller.isCheckedPerform(
                                                newValue, "clinicalPlan");
                                          }),
                                    ),
                                    SizedBox(
                                      width: 10 * fem,
                                      height: 1,
                                    ),
                                    Container(
                                      child: Text(
                                        "Clinical Plan",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 * fem,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            FadeSlideTransition(
                              animation: _formElementAnimation,
                              additionalOffset: 2 * space,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 5 * fem, 0 * fem, 5 * fem),
                                padding: EdgeInsets.fromLTRB(
                                    10 * fem, 0, 10 * fem, 0),
                                // margin: EdgeInsets.only(right: 200),
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.08,
                                      child: Checkbox(
                                          activeColor: AppColors.primaryPurple
                                              .withOpacity(0.1),
                                          checkColor: AppColors.primaryPurple,
                                          value: controller.isPatientEduChecked,
                                          onChanged: (bool? newValue) {
                                            controller.isCheckedPerform(
                                                newValue, "patientEducation");
                                          }),
                                    ),
                                    SizedBox(
                                      width: 10 * fem,
                                      height: 1,
                                    ),
                                    Container(
                                      child: Text(
                                        "Patient Education",
                                        style: TextStyle(
                                            color: AppColors.black,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14 * fem,
                                            fontFamily: 'DM Sans'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(

                    // group167cge (455:270)
                    margin: EdgeInsets.fromLTRB(
                        0 * fem, 10 * fem, 0 * fem, 10 * fem),
                    width: double.infinity,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(12 * fem),
                    // ),
                    child: FadeSlideTransition(
                        animation: _formElementAnimation,
                        additionalOffset: space,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                      primary: AppColors.transparent,
                                      onSurface: AppColors.transparent,
                                      shadowColor: AppColors.transparent,
                                      backgroundColor: AppColors.primaryPurple),
                                  onPressed: () async {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.fromLTRB(0 * fem,
                                            15 * fem, 0 * fem, 15 * fem),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.8,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Generate results",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                // 'Work Sans',
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w500,
                                                height: 1.1725 * fem / fem,
                                                color: Color(0xffffffff),
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ))),
                //  for all three options
                Container(
                  child: Column(
                    children: [
                      // single option
                      EachResult(headerText: "Differential Diagnosis"),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      EachResult(headerText: "Clinical Plan"),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                      EachResult(headerText: "Patient Education"),
                      SizedBox(
                        width: 1,
                        height: 10 * fem,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
