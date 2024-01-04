import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.white,
        textColor: AppColors.black,
        fontSize: 16.0);
  }

  static successToastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static dialogueMessage(BuildContext context, title, desc, bottom) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    print('abcd');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title.toString(),
                      style: TextStyle(
                          fontFamily: 'DM Sans',
                          color: AppColors.primaryPurple,
                          fontWeight: FontWeight.w700,
                          fontSize: 24 * fem),
                    ),
                    // SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        desc.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Colors.black,
                            height: 1.2 * fem,
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        bottom.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 14 * fem,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static updateSucessfully(BuildContext context, desc, bottom) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    print('abcd');
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        desc.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Colors.black,
                            height: 1.2 * fem,
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // SizedBox(height:10),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        bottom.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: AppColors.primaryPurple,
                            fontWeight: FontWeight.w500,
                            fontSize: 14 * fem,
                            decoration: TextDecoration.underline),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  static showDocumentDialogue(BuildContext context, cont) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    // print('abcd');
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
              content: Container(
            height: MediaQuery.of(context).size.height / 2.5,
            width: double.infinity,
            child: cont,
          )
              // Padding(
              //   padding: const EdgeInsets.all(16),
              //   child: cont,
              // ),
              );
        });
  }

  static postSuccessfully(BuildContext context, desc) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        desc.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Colors.black,
                            height: 1.2 * fem,
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  static fetchLoader(BuildContext context, desc) {
    double baseWidth = 360;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(30)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height:8),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        desc.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Colors.black,
                            height: 1.2 * fem,
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
  // String convertDateTimeDisplay(String date) {
  //   final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
  //   final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
  //   final DateTime displayDate = displayFormater.parse(date);
  //   final String formatted = serverFormater.format(displayDate);
  //   return formatted;
  // }

  // static void flushBarErrorMessage(String message, BuildContext context){

  //   showFlushbar(context: context,
  //       flushbar: Flushbar(
  //         forwardAnimationCurve:Curves.decelerate,
  //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         padding: EdgeInsets.all(15),
  //         message: message,
  //         duration: Duration(seconds: 3),
  //         borderRadius: BorderRadius.circular(8),
  //         flushbarPosition: FlushbarPosition.TOP,
  //         backgroundColor: Colors.red,
  //         reverseAnimationCurve: Curves.easeInOut,
  //         positionOffset: 20,
  //         icon: Icon(Icons.error , size: 28 , color: Colors.white,),
  //       )..show(context),

  //   );

  // }

  // static snackBar(String message, BuildContext context){
  //   return ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       backgroundColor: Colors.red,
  //       content: Text(message ))
  //   );
  // }
}
