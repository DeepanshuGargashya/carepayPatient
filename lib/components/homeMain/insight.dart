import 'package:CarePay/components/homeMain/graphTab.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/businessOverview.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:CarePay/components/homeScreen/preBottom.dart';

class InsightWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return InsightState();
  }
}

class InsightState extends State<InsightWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        var fetchData = Provider.of<HomeMainController>(context, listen: false);
        fetchData.initFetchData(context);
      },
    );

    // Timer.periodic(new Duration(seconds: 5), (timer) {
    //   debugPrint(timer.tick.toString());
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    // TODO: implement build
    return Container(
      height: MediaQuery.of(context).size.height / 1.3,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // if(controller.appear== true) ...[
            Visibility(
              visible: controller.isVisible,
              child: Center(
                  child: Text(TextConstant.hello,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.primaryPurple.withOpacity(0.8),
                          fontSize: 24 * fem,
                          fontWeight: FontWeight.w500))),
            ),
            Visibility(
              visible: controller.isVisible,
              child: Center(
                  child: Text(
                      '${TextConstant.dr} ${controller.response['name'].toString()}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.primaryPurple.withOpacity(0.8),
                          fontSize: 24 * fem,
                          fontWeight: FontWeight.w500))),
            ),
            Visibility(
                visible: controller.isVisible, child: SizedBox(height: 15)),
            Visibility(
              visible: controller.isVisible,
              child: Center(
                  child: Text(TextConstant.welcomeCarePay,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 12 * fem,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black))),
            ),
            // ],

            Visibility(
                visible: controller.isVisible, child: SizedBox(height: 15)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 25 * fem,
                    height: 25 * fem,
                    // padding: EdgeInsets.only(top: 25),
                    child: Image(
                        image: AssetImage('assets/images/loanSummary.png')),
                  ),
                  Text(TextConstant.loanSummary,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: InkWell(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   PageTransition(
                  //       type: PageTransitionType.rightToLeftWithFade,
                  //       child: businessOverview()),
                  // );
                },
                child: Container(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.ff1BA169,
                              AppColors.ff50D88F,
                              AppColors.ff3ECFA4
                            ]),
                        // color: Color(0xffFFC699),
                        borderRadius: BorderRadius.circular(12)),
                    width: double.infinity,
                    // height: 160,
                    child: Row(

                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment,
                        children: [
                          Column(children: [
                            Text(controller.loanEarnings.toString(),
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.white,
                                    fontSize: 20 * fem,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 8),
                            Text(TextConstant.loans,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.white,
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400))
                          ]),
                          // SizedBox(height: 8),
                          Column(children: [
                            Text(
                                '${TextConstant.rupee} ${controller.loanAmount.toString()}',
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.white,
                                    fontSize: 20 * fem,
                                    fontWeight: FontWeight.w700)),
                            SizedBox(height: 8),
                            Text(TextConstant.earnings,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.white,
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400))
                          ])
                        ])),
              ),
            ),

            // SizedBox(height:7),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                children: [
                  Container(
                    width: 25 * fem,
                    height: 25 * fem,
                    // padding: EdgeInsets.only(top: 25),
                    child:
                        Image(image: AssetImage('assets/images/insights.png')),
                  ),
                  Text(TextConstant.insights,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          // height: 300,

                          width: MediaQuery.of(context).size.width / 1.3,
                          decoration: const BoxDecoration(
                              color: AppColors.white10,
                              borderRadius: BorderRadius.horizontal()),
                          child: TabBar(
                            onTap: (index) {
                              if (index == 0) {
                                controller.setStatusTabBar('disbursed');
                              } else if (index == 1) {
                                controller.setStatusTabBar("");
                              } else {
                                controller.setStatusTabBar('approved');
                              }
                              ;
                            },
                            labelColor: AppColors.primaryPurple,
                            unselectedLabelColor: AppColors.grey,
                            indicatorColor: AppColors.primaryPurple,
                            tabs: [
                              Tab(
                                  child: Text(TextConstant.disbursed,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w700))),
                              Tab(
                                  child: Text(TextConstant.attempted,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w700))),
                              Tab(
                                  child: Text(TextConstant.approved,
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 12 * fem,
                                          fontWeight: FontWeight.w700))),
                            ],
                          ),
                        ),
                        Container(
                          height: controller.graphResponse != null
                              ? MediaQuery.of(context).size.height / 1.7
                              : MediaQuery.of(context).size.height / 2.2,
                          width: MediaQuery.of(context).size.width,
                          child: TabBarView(
                            children: <Widget>[
                              Column(
                                children: [
                                  GraphTab(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.ECEBFF,
                                        borderRadius: BorderRadius.circular(6)),
                                    // padding: EdgeInsets.fromLTRB(8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                      child: Text(TextConstant.graphShowsD,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.ff47438D)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GraphTab(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.ECEBFF,
                                        borderRadius: BorderRadius.circular(6)),
                                    // padding: EdgeInsets.fromLTRB(8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                      child: Text(TextConstant.graphShowsA,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.ff47438D)),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  GraphTab(),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.ECEBFF,
                                        borderRadius: BorderRadius.circular(6)),
                                    // padding: EdgeInsets.fromLTRB(8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                    child: Padding(
                                      padding:
                                      EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                                      child: Text(TextConstant.graphShowsAp,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.ff47438D)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ])),
            ),

            // SizedBox(height: 10),
            PreBottomWidget(showFaq: true),
          ]),
        ),
      ),
    );
  }
}
