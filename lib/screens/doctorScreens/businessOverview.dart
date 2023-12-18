import 'package:CarePay/components/homeScreen/preBottom.dart';
import 'package:flutter/material.dart';
import 'package:CarePay/res/color.dart';
import 'package:CarePay/res/textConstant.dart';

class businessOverview extends StatefulWidget {
  const businessOverview({Key? key}) : super(key: key);

  @override
  State<businessOverview> createState() => _businessOverviewState();
}

class _businessOverviewState extends State<businessOverview> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
      child: Scaffold(
          // backgroundColor : AppColors.white,
          appBar: AppBar(
            elevation: 1,
            backgroundColor: AppColors.white,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, size: 30, color: AppColors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(TextConstant.businessOverview,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14 * fem)),
          ),
          backgroundColor: AppColors.white,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                        decoration: BoxDecoration(
                            color: AppColors.ECEBFF,
                            // color: Color(0xffFFC699),
                            borderRadius: BorderRadius.circular(12)),
                        width: double.infinity,
                        // height: 160,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            // crossAxisAlignment: CrossAxisAlignment,
                            children: [
                              Column(children: [
                                Text('1,250',
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.primaryPurple,
                                        fontSize: 20 * fem,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 8),
                                Text(TextConstant.loans,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.primaryPurple,
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400))
                              ]),
                              SizedBox(height: 8),
                              Column(children: [
                                Text('₹12,23,345',
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.primaryPurple,
                                        fontSize: 20 * fem,
                                        fontWeight: FontWeight.w700)),
                                SizedBox(height: 8),
                                Text(TextConstant.earnings,
                                    style: TextStyle(
                                        fontFamily: 'DM Sans',
                                        color: AppColors.primaryPurple,
                                        fontSize: 14 * fem,
                                        fontWeight: FontWeight.w400))
                              ])
                            ])),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(top: 25),
                              child: Image(
                                  image: AssetImage('assets/images/coin.png')),
                            ),
                            SizedBox(width: 10),
                            Container(
                              child: Text(
                                TextConstant.money,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 32 * fem,
                          height: 31 * fem,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5 * fem),
                              color: AppColors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                              SizedBox(
                                width: 1,
                                height: 1,
                              ),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                              SizedBox(
                                width: 1,
                                height: 1,
                              ),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            // color: Color(0xffFFC699),
                            borderRadius: BorderRadius.circular(12)),
                        width: double.infinity,
                        // height: 160,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('₹87,000',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.subvention,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    )
                                  ]),
                              SizedBox(height: 8),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('₹12,23,345',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.loanedAmount,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    ),
                                  ])
                            ])),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              // padding: EdgeInsets.only(top: 25),
                              child: Image(
                                  image:
                                      AssetImage('assets/images/numbers.png')),
                            ),
                            SizedBox(width: 10),
                            Container(
                              child: Text(
                                TextConstant.number,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 32 * fem,
                          height: 31 * fem,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5 * fem),
                              color: AppColors.white),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                              SizedBox(
                                width: 1,
                                height: 1,
                              ),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                              SizedBox(
                                width: 1,
                                height: 1,
                              ),
                              Container(
                                width: 6,
                                height: 6,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(500),
                                    color: AppColors.primaryPurple),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            // color: Color(0xffFFC699),
                            borderRadius: BorderRadius.circular(12)),
                        width: double.infinity,
                        // height: 160,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment,
                            children: [
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('1,250',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.disbursedLoans,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    ),
                                    Text('1,450',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.applicationCount,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    ),
                                    Text('149',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.rejectedLoans,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.primaryOrange,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    )
                                  ]),
                              SizedBox(height: 8),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('1,350',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.approvedLoans,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    ),
                                    Text('33',
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 24 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(TextConstant.inDisbursal,
                                            style: TextStyle(
                                                fontFamily: 'DM Sans',
                                                color: AppColors.black,
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400)),
                                        Container(
                                            child: IconButton(
                                          icon: Icon(Icons.info_outline,
                                              color: AppColors.black),
                                          onPressed: () {},
                                        )),
                                      ],
                                    ),
                                  ])
                            ])),
                  ]),
                ),
                PreBottomWidget(
                  showFaq: false,
                ),
                SizedBox(height: 20),
              ],
            ),
          )

          // SizedBox(height:20),

          ),
    );
  }
}
