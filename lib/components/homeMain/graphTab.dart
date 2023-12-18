import 'package:CarePay/components/fade_slide_transition.dart';
import 'package:CarePay/components/homeMain/graph.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GraphTab extends StatefulWidget {
  const GraphTab({Key? key}) : super(key: key);

  @override
  State<GraphTab> createState() => _GraphTabState();
}

class _GraphTabState extends State<GraphTab>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _formElementAnimation;
  late final AnimationController _animationController;
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
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      padding: EdgeInsets.fromLTRB(0 * fem, 10 * fem, 0 * fem, 0 * fem),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.25,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  child: DefaultTabController(
                      length: 2, // length of tabs
                      initialIndex: 0,
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.4,
                                  height: 30 * fem,
                                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),

                                  // width: size.width*0.44,
                                  decoration: BoxDecoration(
                                      color: AppColors.ECEBFF,
                                      borderRadius: BorderRadius.circular(6)),
                                  child: TabBar(
                                    onTap: (index) {
                                      if (index == 0) {
                                        controller.setResultTabBar('sum');
                                      } else {
                                        controller.setResultTabBar("");
                                      }
                                      ;
                                    },
                                    padding: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),

                                    // labelPadding: EdgeInsets.only(top: 5,bottom:5),
                                    labelColor: AppColors.primaryPurple,
                                    unselectedLabelColor:
                                        AppColors.primaryPurple,
                                    indicator: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: AppColors.white,
                                    ),
                                    tabs: [
                                      Tab(
                                          child: Text(TextConstant.money,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12 * fem))),
                                      Tab(
                                          child: Text(TextConstant.count,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12 * fem))),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ])),
                ),
              ],
            ),
          ),
          // SizedBox(height: 16),
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            if (controller.graphResponse != null) ...[
              Graph(data: controller.graphResponse),
            ] else ...[
              Center(
                child: FadeSlideTransition(
                  additionalOffset: 0.0,
                  animation: _formElementAnimation,
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 150 * fem,
                        child: Image.asset("assets/images/noTransactions.png"),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.fromLTRB(
                            25 * fem, 0 * fem, 25 * fem, 8 * fem),
                        child: Text(
                          "Sit back and relax, wait for your patients to apply for their loans to show here",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
            // SizedBox(height: 20),
            // Container(
            //   decoration: BoxDecoration(
            //       color: AppColors.ECEBFF,
            //       borderRadius: BorderRadius.circular(6)),
            //   // padding: EdgeInsets.fromLTRB(8 * fem, 8 * fem, 8 * fem, 8 * fem),
            //   child: Padding(
            //     padding:
            //         EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
            //     child: Text(TextConstant.graphShows,
            //         textAlign: TextAlign.left,
            //         style: TextStyle(
            //             fontFamily: 'DM Sans',
            //             fontWeight: FontWeight.w400,
            //             color: AppColors.ff47438D)),
            //   ),
            // ),
            // SizedBox(height: 2 * fem),
          ])
        ],
      ),
    );
  }
}
