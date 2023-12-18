import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/view_model/doctorFlow/aiAssistantController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SameResult extends StatefulWidget {
  var headerText = "";
  SameResult({required this.headerText});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SameResultState();
  }
}

class SameResultState extends State<SameResult>
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
    // TODO: implement build
    return Container(
      child: FadeSlideTransition(
        additionalOffset: space,
        animation: _formElementAnimation,
        child: Column(children: [
          //for header
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Row(
                      children: [
                        Text(
                          widget.headerText.toString(),
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.black.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                              fontSize: 14 * fem),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(14),
                              child: Column(
                                // mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // alignment: Alignment.center,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height: 6 * fem,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4 * fem),
                                            color: AppColors.D9D9D9),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 5 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                    child: Text(
                                      "Share",
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color:
                                              AppColors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14 * fem),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 5 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                    child: Text(
                                      "Copy text",
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color:
                                              AppColors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14 * fem),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 5 * fem,
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                    child: Text(
                                      "Edit text",
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          color:
                                              AppColors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14 * fem),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 1,
                                    height: 5 * fem,
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Container(
                      width: 32 * fem,
                      height: 31 * fem,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5 * fem),
                          color: AppColors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: AppColors.primaryPurple),
                          ),
                          SizedBox(
                            width: 1,
                            height: 3,
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: AppColors.primaryPurple),
                          ),
                          SizedBox(
                            width: 1,
                            height: 3,
                          ),
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(500),
                                color: AppColors.primaryPurple),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
          //for bottom
          Container(
            margin: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 10 * fem),
            padding:
                EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 16 * fem),
            decoration: BoxDecoration(
                color: AppColors.ECEBFF,
                borderRadius: BorderRadius.circular(4 * fem)),
            child: Text(
              "1. Congestive Heart Failure The most likely diagnosis for this patient is congestive heart failure (CHF). The patient's age, history of myocardial infarction (MI), and presenting symptoms all point towards CHF. Dyspnea on exertion is a common symptom in patients with heart failure as the heart struggles to pump blood effectively, leading to fluid accumulation in the lungs. Bilateral lower extremity edema, an S3 heart sound, and jugular venous distension (JVD) are classic signs of fluid overload seen in CHF. Additionally, the newly discovered ejection fraction (EF) of 30% indicates systolic dysfunction, which further supports the diagnosis of CHF.",
              style: TextStyle(
                  color: AppColors.black,
                  fontSize: 14 * fem,
                  fontWeight: FontWeight.w400),
            ),
          )
        ]),
      ),
    );
  }
}
