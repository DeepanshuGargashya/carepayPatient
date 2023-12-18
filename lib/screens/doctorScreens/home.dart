import 'package:CarePay/components/homeScreen/preBottom.dart';
import 'package:CarePay/screens/doctorScreens/doctorProfile.dart';
import 'package:CarePay/view_model/doctorFlow/homeController.dart';
import 'package:flutter/material.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var fetchData = Provider.of<HomeController>(context, listen: false);
      fetchData.initFetchData(context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
              backgroundColor: AppColors.white,
              appBar: AppBar(
                centerTitle: false,
                // automaticallyImplyLeading: false,
                elevation: 0,
                leadingWidth: 0 * fem,
                backgroundColor: AppColors.white,
                title: Column(
                  children: [
                    SizedBox(height: 8 * fem),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(height:5),
                          Container(
                            width: 115 * fem,
                            height: 45 * fem,
                            // padding: EdgeInsets.only(top: 1 * fem),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/carePayLogo.png')),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .rightToLeftWithFade,
                                      child: DoctorProfileScreen()),
                                );
                              },
                              child: Container(
                                width: 40 * fem,
                                height: 40 * fem,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.secondaryOrange,
                                        width: 2 * fem),
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.ECEBFF,

                                    radius: 100,
                                    child: Text(
                                      controller.name.toString(),
                                      style: TextStyle(
                                          fontFamily: 'DM Sans',
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryPurple),
                                    ), //Text
                                  ),
                                ),
                              )),
                        ]),
                  ],
                ),
              ),
              body: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.148,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 7),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.ffFFC699,
                                          AppColors.ffF29F73
                                        ]),
                                    // color: Color(0xffFFC699),
                                    borderRadius: BorderRadius.circular(12)),
                                width: double.infinity,
                                // height: 160,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      width: MediaQuery.of(context).size.width /
                                          2.8,

                                      // height: MediaQuery.of,
                                      // padding: EdgeInsets.only(top: 150),
                                      child: SizedBox(
                                          // width:
                                          //     MediaQuery.of(context).size.width,
                                          height: 100,
                                          child: Image.asset(
                                              "assets/images/logo.png")),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.8,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10 * fem, 30 * fem, 0),
                                            child: Text(
                                              TextConstant.underReviews,
                                              style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.ff47438D,
                                                fontSize: 24 * fem,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 0, 20 * fem, 10 * fem),
                                            child: Text(
                                              TextConstant
                                                  .applicationUnderReview,
                                              style: TextStyle(
                                                  fontFamily: 'DM Sans',
                                                  // letterSpacing: 1*fem,
                                                  color: AppColors.ff47438D,
                                                  fontSize: 12 * fem,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0, left: 10, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 15 * fem, 0, 15 * fem),
                                            child: Text(
                                              TextConstant.refreshStatus,
                                              style: TextStyle(
                                                  color: AppColors.white,
                                                  fontFamily: 'DM Sans',
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14 * fem),
                                            ),
                                          ),
                                          onPressed: () {
                                            controller
                                                .getDoctorVerificationStatus();
                                          },
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColors.primaryPurple,
                                              // fixedSize: Size(380, 50),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4 * fem)))),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            PreBottomWidget(
                              showFaq: true,
                            )
                          ]),
                    ),
                  ),
                ),
              ]))),
    );
  }
}
