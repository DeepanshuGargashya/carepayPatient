import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/doctorScreens/allTransaction.dart';
import 'package:CarePay/view_model/doctorFlow/homeMainController.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:CarePay/res/textConstant.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../screens/doctorScreens/dispute.dart';

class EachTransactionWidget extends StatefulWidget {
  var eachResponseItem;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EachTransactionState();
  }
}

class EachTransactionState extends State<EachTransactionWidget> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeMainController>(context);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 30 * fem),
          for (int i = 0; i < controller.transactionResponse.length; i++) ...[
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
                            Text(
                              '${TextConstant.loanId} ${controller.transactionResponse[i]['loan_id'].toString()}',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: AppColors.black,
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 8),
                            TextButton.icon(
                              icon: Icon(
                                Icons.warning_outlined,
                                color: AppColors.primaryPurple,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType
                                            .rightToLeftWithFade,
                                        child: Dispute(loanId: controller.transactionResponse[i]['loan_id'].toString(),userId: controller.transactionResponse[i]['user_id'].toString())));
                              },
                              label: Text(
                                TextConstant.dispute,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14 * fem),
                              ),
                            ),
                            TextButton.icon(
                              icon: Icon(
                                Icons.phone,
                                color: AppColors.primaryPurple,
                              ),
                              onPressed: () async {
                                Uri phoneno = Uri.parse(
                                    'tel:${controller.transactionResponse[i]['mobile_number'].toString()}');
                                if (await launchUrl(phoneno)) {
                                  //dialer opened
                                } else {
                                  //dailer is not opened
                                }
                              },
                              label: Text(
                                TextConstant.patient,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14 * fem),
                              ),
                            ),
                            TextButton.icon(
                              icon: Icon(
                                Icons.support_agent,
                                color: AppColors.primaryPurple,
                              ),
                              onPressed: () async {
                                Uri phoneno =
                                    Uri.parse('tel:${TextConstant.helpNumber}');
                                if (await launchUrl(phoneno)) {
                                  //dialer opened
                                } else {
                                  //dailer is not opened
                                }
                              },
                              label: Text(
                                TextConstant.help,
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    color: AppColors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14 * fem),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8 * fem),
                            color: AppColors.ECEBFF),
                        child: Column(
                          children: [
                            Text(
                                '${DateFormat('dd').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionResponse[i]['apply_date']))}',
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 12 * fem,
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.w700)),
                            Text(
                                '${DateFormat('MMMM').format(DateTime.fromMillisecondsSinceEpoch(controller.transactionResponse[i]['apply_date'])).toString().substring(0, 3)}',
                                style: TextStyle(
                                    fontFamily: 'DM Sans',
                                    fontSize: 12 * fem,
                                    color: AppColors.primaryPurple,
                                    fontWeight: FontWeight.w700)),
                          ],
                        )),
                    Container(
                        padding: EdgeInsets.fromLTRB(
                            10 * fem, 15 * fem, 10 * fem, 15 * fem),
                        decoration: BoxDecoration(
                            color: i % 2 == 0
                                ? AppColors.tertiaryOrange
                                : AppColors.ffE9E9FF,
                            // color: Color(0xffFFC699),
                            borderRadius: BorderRadius.circular(8 * fem)),
                        width: MediaQuery.of(context).size.width / 1.2,
                        // constraints:BoxConstraints(maxWidth:double.infinity),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          '${TextConstant.rupee} ${controller.transactionResponse[i]['loan_amount'].toString()}',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black,
                                              fontSize: 20 * fem,
                                              fontWeight: FontWeight.w700)),
                                      SizedBox(height: 4),
                                      Text(TextConstant.loanAmount,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black,
                                              fontSize: 10 * fem,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(height: 10 * fem),
                                      Text(
                                          controller.transactionResponse[i]
                                                  ['first_name']
                                              .toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black,
                                              fontSize: 14 * fem,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(height: 4),
                                      Text(TextConstant.patientName,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black,
                                              fontSize: 10 * fem,
                                              fontWeight: FontWeight.w400)),
                                    ]),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: controller
                                                        .transactionResponse[i][
                                                            'loan_sanction_status']
                                                        .toString() ==
                                                    "Approved"
                                                ? AppColors.primaryOrange
                                                : AppColors.primaryPurple),
                                        child: Text(
                                            controller.transactionResponse[i]
                                                    ['loan_sanction_status']
                                                .toString(),
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontSize: 10 * fem,
                                                fontFamily: 'DM Sans',
                                                color: AppColors.white,
                                                fontWeight: FontWeight.w700))),
                                    SizedBox(height: 4),
                                    Text(TextConstant.loanStatus,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 10 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 10 * fem),
                                    Text(
                                        controller.transactionResponse[i]
                                                        ['loan_reason']
                                                    .toString()
                                                    .length >
                                                12
                                            ? '${controller.transactionResponse[i]['loan_reason'].toString().substring(0, 8)}...'
                                            : controller.transactionResponse[i]
                                                    ['loan_reason']
                                                .toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(height: 4),
                                    Text(TextConstant.purpose,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: 'DM Sans',
                                            color: AppColors.black,
                                            fontSize: 10 * fem,
                                            fontWeight: FontWeight.w400)),
                                  ])
                            ])),
                  ]),
            ),
            SizedBox(height: 10 * fem),
          ],

          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 22 * fem, left: 0, right: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(

                    child: ElevatedButton(

                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, 15 * fem, 0, 15 * fem),
                          child: Text(
                            TextConstant.viewAll,
                            style: TextStyle(
                                color: AppColors.primaryPurple,
                                fontFamily: 'DM Sans',
                                fontWeight: FontWeight.w700,
                                fontSize: 14 * fem),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child: AllTransactionScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                            primary: AppColors.ECEBFF,
                            // fixedSize: Size(370, 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4*fem)))),
                  ),
                ],
              ),
            ),
          ),

          // Container(
          //   padding: EdgeInsets.only(top: 0),
          //   child: Center(
          //     child: ElevatedButton(
          //         child: Text(
          //           TextConstant.viewAll,
          //           style: TextStyle(
          //               color: AppColors.primaryPurple,
          //               fontFamily: 'DM Sans',
          //               fontWeight: FontWeight.w700,
          //               fontSize: 14 * fem),
          //         ),
          //         onPressed: () {
          //           Navigator.push(
          //             context,
          //             PageTransition(
          //                 type: PageTransitionType.rightToLeftWithFade,
          //                 child: AllTransactionScreen()),
          //           );
          //         },
          //         style: ElevatedButton.styleFrom(
          //             primary: AppColors.ECEBFF,
          //             fixedSize: Size(370, 50),
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(10)))),
          //   ),
          // ),
        ]);
  }
}
