import 'package:CarePay/res/color.dart';
import 'package:flutter/material.dart';

class Loader {
  void fetchData(BuildContext context) {
    Future.delayed(Duration.zero, () {
      showDialog(
          barrierDismissible: false,
          barrierColor: Colors.black.withOpacity(0.4),
          context: context,
          builder: (_) {
            return Dialog(
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                  // width: 20,
                  // height: 20 ,
                  color: Colors.transparent,
                  alignment: FractionalOffset.center,
                  child:
                      // Image(
                      //     image:
                      //     AssetImage('assets/images/loader.gif')),

                      CircularProgressIndicator(
                    strokeWidth: 8,
                    color: AppColors.primaryPurple,
                  )),
            );
          });
    });
  }

  void loaderClose(BuildContext context) {
    Navigator.of(context).pop();
  }
}
