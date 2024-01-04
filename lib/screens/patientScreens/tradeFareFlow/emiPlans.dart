import 'package:CarePay/res/color.dart';
import 'package:CarePay/screens/patientScreens/tradeFareFlow/advanceEmi.dart';
import 'package:CarePay/view_model/patientFlow/emiPlansController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class EmiPlansScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EmiPlansState();
  }
}

class EmiPlansState extends State<EmiPlansScreen> {
  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / 360;
    double ffem = fem * 0.97;
    final controller = Provider.of<EmiPlansController>(context);
    // TODO: implement build

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0 * fem),
        child: AppBar(
          backgroundColor: AppColors.whiteColor,
          centerTitle: false,
          leading: IconButton(
            tooltip: 'Previous choice',
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Credit application',
            style: TextStyle(
                fontSize: 18 * fem,
                fontWeight: FontWeight.w500,
                color: AppColors.black.withOpacity(0.8)),
          ),
          automaticallyImplyLeading: false,
          // actions: [Text('Charging Status')],

          elevation: 2,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15 * fem),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20 * fem,
              ),
              Text('EMI Plans Selection',
                  style: TextStyle(
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w700,
                      color: Colors.black)),
              SizedBox(
                height: 10 * fem,
              ),
              Text('Credit amount',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.4))),
              SizedBox(
                height: 10 * fem,
              ),
              Text('Rs 90,000',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(
                height: 20 * fem,
              ),
              Text('Select EMI options',
                  style: TextStyle(
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.black)),
              SizedBox(height: 20 * fem),
              Container(
                padding:
                    EdgeInsets.fromLTRB(10 * fem, 10 * fem, 10 * fem, 10 * fem),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // border: Border.all(
                    //   color: Colors.black,
                    //   // width: 5,
                    // ),
                    // boxShadow: [
                    //   BoxShadow(
                    //       color: Color(0xff514C9F),
                    //       spreadRadius: 0,
                    //       blurRadius: 0,
                    //       offset: const Offset(-4, 6)
                    //   )
                    // ],
                    color: Color(0xFFFAE1CD),
                    borderRadius: BorderRadius.circular(5 * fem)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Please note:',
                          style: TextStyle(
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.8))),
                      SizedBox(height: 10 * fem),
                      Text(
                          'You will have to make payment of the advance to the clinic/doctor/hospital according to the option selected.',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.8))),
                    ]),
              ),
              SizedBox(height: 20 * fem),
              // Column(
              //       children: [
              //         for (var item in borrowFor)
              //           ListTile(
              //             visualDensity: VisualDensity(
              //                 horizontal: -0, vertical: -3),
              //             minLeadingWidth: 0 * fem,
              //             contentPadding: EdgeInsets.all(0),
              //             minVerticalPadding: 0,
              //             horizontalTitleGap: 0,
              //             title: Text('${item.toString()}'),
              //             leading: Radio(
              //               activeColor:
              //               AppColors.black,
              //               value: item.toString(),
              //               groupValue: borrowForValue
              //                   .toString(),
              //               onChanged: (value) {
              //                 setBorrowFor(
              //                     value.toString());
              //                 // setState(() {
              //                 //   genderValue = value.toString();
              //                 // });
              //               },
              //             ),
              //           ),
              //       ],
              //     ),

              InkWell(
                onTap: () {
                  controller.setEmiTab("12");
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      15 * fem, 20 * fem, 15 * fem, 20 * fem),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 0.4,
                      ),
                      // color: AppColors.grey,
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Color(0xff514C9F),
                      //       spreadRadius: 0,
                      //       blurRadius: 0,
                      //       offset: const Offset(-4, 6)
                      //   )
                      // ],
                      //   color: Color(0xFFFAE1CD),
                      borderRadius: BorderRadius.circular(5 * fem)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        // color: AppColors.red,
                        width: MediaQuery.of(context).size.width / 6.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(0.5 * fem),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50 * fem),
                                border: Border.all(
                                    // color: controller.categoryValue ==
                                    //     item.toString()
                                    color: Colors.grey,
                                    // : AppColors.whiteColor,
                                    width: 1 * fem),
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                radius: 11,
                                child: CircleAvatar(
                                  backgroundColor: controller.emiTab == "12"
                                      ? Color(0xff514C9F)
                                      : AppColors.transparent,
                                  radius: 8,
                                ),
                              ),
                            ),
                            // Radio(
                            //   activeColor:
                            //   AppColors.black,
                            //   value: item,
                            //   groupValue:,
                            //   onChanged:
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Effective tenure',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('12 months',
                                style: TextStyle(
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Divider(
                              color: Colors.black,
                            ),
                            Text('Final credit amount',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Processing fees',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Interest rate',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Advance payment',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EMI amount',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 5,000',
                                style: TextStyle(
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Divider(
                              color: Colors.black,
                            ),
                            Text('₹ 60,000',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 1800 (2%)',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('0',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 30,000 ',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                      SizedBox(height: 10 * fem),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20 * fem),

              InkWell(
                onTap: () {
                  controller.setEmiTab("8");
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      15 * fem, 20 * fem, 15 * fem, 20 * fem),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 0.4,
                      ),
                      // boxShadow: [
                      //   BoxShadow(
                      //       color: Color(0xff514C9F),
                      //       spreadRadius: 0,
                      //       blurRadius: 0,
                      //       offset: const Offset(-4, 6)
                      //   )
                      // ],
                      //   color: Color(0xFFFAE1CD),
                      borderRadius: BorderRadius.circular(5 * fem)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 6.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.all(0.5 * fem),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50 * fem),
                                border: Border.all(
                                    // color: controller.categoryValue ==
                                    //     item.toString()
                                    color: Colors.grey,
                                    // : AppColors.whiteColor,
                                    width: 1 * fem),
                              ),
                              child: CircleAvatar(
                                backgroundColor: AppColors.transparent,
                                radius: 11,
                                child: CircleAvatar(
                                  backgroundColor: controller.emiTab == "8"
                                      ? Color(0xff514C9F)
                                      : AppColors.transparent,
                                  radius: 8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Effective tenure',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('8 months',
                                style: TextStyle(
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Divider(
                              color: Colors.black,
                            ),
                            Text('Final credit amount',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Processing fees',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Interest rate',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('Advance payment',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EMI amount',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 5,000',
                                style: TextStyle(
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Divider(
                              color: Colors.black,
                            ),
                            Text('₹ 60,000',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 1800 (2%)',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('0',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                            SizedBox(height: 10 * fem),
                            Text('₹ 30,000 ',
                                style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.8))),
                          ],
                        ),
                      ),
                      SizedBox(height: 10 * fem),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20 * fem),
              Container(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(top: 10 * fem, left: 0, right: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 15 * fem, 0, 15 * fem),
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DM Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14 * fem),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: AdvanceEmi()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff514C9F),
                                // fixedSize: Size(380, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20 * fem),
              Center(
                  child: Text('For more details and enquiries, reach out to us',
                      style: TextStyle(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          color: AppColors.black.withOpacity(0.8)))),
              SizedBox(height: 15 * fem),
              InkWell(
                  onTap: () {
                    // Navigator.pushReplacement(context, MaterialPageRoute<void>(
                    //   builder: (BuildContext context) =>  AddChargers(),
                    // ),);
                  },
                  child: Center(
                      child: Text('Contact Support',
                          style: TextStyle(
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF514C9F),
                              decoration: TextDecoration.underline)))),
            ],
          ),
        ),
      ),
    );
  }
}
