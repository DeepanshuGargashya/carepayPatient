import 'package:CarePay/screens/patientScreens/scannerWithScanWindow.dart';
import 'package:CarePay/view_model/patientFlow/confirmationPageController.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../res/color.dart';
import '../../res/textConstant.dart';

class ConfirmationPage extends StatefulWidget {
  dynamic doctorRes;
  dynamic doctorId;
  ConfirmationPage(
      {super.key, required this.doctorRes, required this.doctorId});
  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  @override
  void initState() {
    print("inside initstate of confirmpage");
    // print(widget.doctorRes);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ConfirmationController>(context);
    print(widget.doctorRes);
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                TextConstant.qrScan,
                style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              elevation: 1,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              flexibleSpace: Container(
                decoration: BoxDecoration(color: Colors.white),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: Text(TextConstant.youHave,
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                        'Dr. ${widget.doctorRes['name'].toString()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 32 * fem,
                            color: AppColors.primaryPurple),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Text(
                          '${widget.doctorRes['speciality'].toString()}',
                          style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w700,
                              color: AppColors.black)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: ElevatedButton(
                            child: Text(
                              '${widget.doctorRes['clinic'].toString()}',
                              style: TextStyle(
                                  color: AppColors.black,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16 * fem),
                            ),
                            onPressed: () {
                              // if (formKey.currentState!.validate()
                              // // && formKeyMob.currentState!.validate()
                              // ) {
                              //   controller.handleSubmition(context);
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: AppColors.tertiaryGreen,
                                fixedSize: Size(390, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            color: AppColors.tertiaryOrange,
                            borderRadius: BorderRadius.circular(6)),
                        padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                        child: Text(
                            TextConstant.loanAvailed(
                                widget.doctorRes['name'].toString()),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'DM Sans',
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: AppColors.primaryPurple))),
                    SizedBox(
                      height: 30,
                    ),
                    Text(TextConstant.note,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400,
                            color: AppColors.black)),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: ElevatedButton(
                            child: Text(
                              TextConstant.proceedWithLoan,
                              style: TextStyle(
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14 * fem),
                            ),
                            onPressed: () {
                              controller.handleProceed(
                                  context, widget.doctorRes, widget.doctorId);

                              // if (formKey.currentState!.validate()
                              // // && formKeyMob.currentState!.validate()
                              // ) {
                              //   controller.handleSubmition(context);
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryPurple,
                                fixedSize: Size(390, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      TextConstant.or,
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 15 * fem),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: ElevatedButton(
                            child: Text(
                              TextConstant.scanAgain,
                              style: TextStyle(
                                  color: AppColors.primaryPurple,
                                  fontFamily: 'DM Sans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14 * fem),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                    type:
                                        PageTransitionType.rightToLeftWithFade,
                                    child: BarcodeScannerWithScanWindow()),
                              );
                              // if (formKey.currentState!.validate()
                              // // && formKeyMob.currentState!.validate()
                              // ) {
                              //   controller.handleSubmition(context);
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: AppColors.ECEBFF,
                                fixedSize: Size(390, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(4 * fem)))),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
