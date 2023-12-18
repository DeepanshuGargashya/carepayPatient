import 'package:CarePay/res/color.dart';
import 'package:CarePay/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/textConstant.dart';
import '../screens/doctorScreens/chatSupport.dart';
import '../screens/doctorScreens/dispute.dart';

class DoctorTransactionsCardScreen extends StatefulWidget {
  var eachResponseItem;
  DoctorTransactionsCardScreen({required this.eachResponseItem});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DoctorTransactionsCardState();
  }
}

class DoctorTransactionsCardState extends State<DoctorTransactionsCardScreen> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final space = height > 650 ? 8.0 : 16.0;
    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(0 * fem, 15 * fem, 0 * fem, 15 * fem),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
              bottom: BorderSide(
                color: AppColors.black.withOpacity(0.2),
                width: 2,
              ),
            )),
            padding: EdgeInsets.fromLTRB(6 * fem, 5 * fem, 2 * fem, 5 * fem),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Text.rich(TextSpan(children: <InlineSpan>[
                    TextSpan(
                      text:
                          '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.eachResponseItem['apply_date']))}, ',
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.black.withOpacity(0.8),
                          fontSize: 12 * fem,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: DateTime.fromMillisecondsSinceEpoch(
                              widget.eachResponseItem['apply_date'])
                          .toString()
                          .substring(10, 16),
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.black.withOpacity(0.4),
                          fontSize: 12 * fem,
                          fontWeight: FontWeight.w400),
                    ),
                  ])),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          Utils.dialogueMessage(
                              context,
                              "Loan Id is",
                              widget.eachResponseItem['loan_id'].toString(),
                              "Back");
                        },
                        child: Text(
                            'Loan ID : ${widget.eachResponseItem['loan_id'].toString().substring(0, 5)}...',
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                color: AppColors.black.withOpacity(0.4),
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.w400)),
                      ),
                      SizedBox(
                        width: 5 * fem,
                        height: 1,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Loan ID : ${widget.eachResponseItem['loan_id'].toString()}',
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
                                                child: Dispute(loanId: widget.eachResponseItem['loan_id'].toString(),userId:widget.eachResponseItem['user_id'].toString())),
                                          );
                                        },
                                        label: Text(
                                          TextConstant.dispute,
                                          style: TextStyle(
                                              fontFamily: 'DM Sans',
                                              color: AppColors.black
                                                  .withOpacity(0.8),
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
                                              'tel:${widget.eachResponseItem['mobile_number'].toString()}');
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
                                              color: AppColors.black
                                                  .withOpacity(0.8),
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
                                          Uri phoneno = Uri.parse(
                                              'tel:${TextConstant.helpNumber}');
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
                                              color: AppColors.black
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14 * fem),
                                        ),
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
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10 * fem, 5 * fem, 10 * fem, 5 * fem),
            child: Column(
              children: [
                SizedBox(
                  width: 1,
                  height: 20 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text('Patient name',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple.withOpacity(0.6),
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text(
                          '${widget.eachResponseItem['first_name'].toString()} ${widget.eachResponseItem['middle_name'] != null ? widget.eachResponseItem['middle_name'].toString() : ""} ${widget.eachResponseItem['last_name'] != null ? widget.eachResponseItem['last_name'].toString() : ""}',
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.black.withOpacity(0.8),
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: 20 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text('Amount',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple.withOpacity(0.6),
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              '₹ ${widget.eachResponseItem['loan_amount'] != null ? widget.eachResponseItem['loan_amount'].toString() : 0}',
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: AppColors.black.withOpacity(0.8),
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: 20 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text('Loan status',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple.withOpacity(0.6),
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                              widget.eachResponseItem['loan_sanction_status'] !=
                                      null
                                  ? widget
                                      .eachResponseItem['loan_sanction_status']
                                      .toString()
                                  : "",
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  color: widget.eachResponseItem[
                                                  'loan_sanction_status']
                                              .toString() ==
                                          'Approved'
                                      ? AppColors.primaryOrange
                                      : AppColors.primaryGreen,
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w700)),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: 1,
                  height: 20 * fem,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text('Loan purpose',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.primaryPurple.withOpacity(0.6),
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.6,
                      child: Text(
                          widget.eachResponseItem['loan_reason'] != null
                              ? widget.eachResponseItem['loan_reason']
                                  .toString()
                              : "",
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              color: AppColors.black.withOpacity(0.8),
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400)),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
